import type { Page, Locator, expect } from "@playwright/test";

export class HomePage {
    private readonly url: string = "/";
    public readonly pageBody: Locator;
    public readonly freeOpenSourceSpatialDiv: Locator;
    public readonly qgisSupportersHeading: Locator;
    public readonly supportersGridDiv: Locator;
    public readonly addYourLogoHereText: Locator;
    public readonly silverPartnerText: Locator;
    public readonly otherSupporters: Locator;

    public readonly textList: string[] = [
        "Free and Open Source",
        "QGIS.org Blog",
        "Official news and announcements from the QGIS project.",
    ];

    constructor(public readonly page: Page) {
        this.pageBody = this.page.locator("body");
        this.freeOpenSourceSpatialDiv = this.page
            .locator("div")
            .filter({ hasText: "Free and open source" })
            .first();
        this.qgisSupportersHeading = this.page.getByRole("heading", {
            name: "QGIS sustaining members",
        });
        this.addYourLogoHereText = this.page
            .locator("div")
            .filter({ hasText: "Add your logo here?" })
            .nth(2);
        this.silverPartnerText = this.page
            .locator("div")
            .filter({ hasText: "Large membership" })
            .nth(2);
        this.supportersGridDiv = this.page
            .locator(".supporters-grid > div:nth-child(3)")
            .first();
        this.otherSupporters = this.page
            .locator(".container > div:nth-child(3)")
            .first();
    }

    async goto() {
        await this.page.goto(this.url);
    }
}
