import { test as base, expect } from "@playwright/test";
import { Sidebar } from "./fixtures/sidebar";

type SidebarFixtures = {
    sidebar: Sidebar;
};

const test = base.extend<SidebarFixtures>({
    sidebar: async ({ page }, use) => {
        const sidebar = new Sidebar(page);
        await use(sidebar);
    },
});

test.describe("Sidebar navigation", () => {
    test.beforeEach(async ({ page }) => {
        await page.goto("/");
    });

    test("Home link is visible", async ({ sidebar }) => {
        await expect(sidebar.sidebar).toBeVisible();
        await expect(sidebar.homeLink).toBeVisible();
    });

    test("Authors submenu expands and navigates to author page", async ({
        page,
        sidebar,
    }) => {

        // Expand the authors submenu
        await sidebar.authorsToggle.click();
        await expect(sidebar.firstAuthorLink).toBeVisible();

        // Navigate to the first author's page
        const authorName = await sidebar.firstAuthorLink.textContent();
        await sidebar.firstAuthorLink.click();
        await expect(page).toHaveURL(/\/author\//);

        // Author page shows the author's name as a heading and sidebar remains
        await expect(sidebar.sidebar).toBeVisible();
        await expect(page.getByRole("heading", { level: 1 })).toBeVisible();
    });

    test("Categories submenu expands and navigates to category page", async ({
        page,
        sidebar,
    }) => {

        // Expand the categories submenu
        await sidebar.categoriesToggle.click();
        await expect(sidebar.firstCategoryLink).toBeVisible();

        // Navigate to the first category page
        await sidebar.firstCategoryLink.click();
        await expect(page).toHaveURL(/\/category\//);

        // Category page shows a heading and sidebar remains
        await expect(sidebar.sidebar).toBeVisible();
        await expect(page.getByRole("heading", { level: 1 })).toBeVisible();
    });
});

