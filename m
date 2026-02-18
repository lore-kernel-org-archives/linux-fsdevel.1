Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1A2D6E76;
	Wed, 18 Feb 2026 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419381; cv=none; b=fnka1c934K/rleEwqnN0tui7yEtFqkKD3dz4KJKWXAaotXNGR+FE3tfarZfTI+dPIEXb//4fCURNPccLI5luKdGqSPOeJrPpwqe296pJNYJyX3bAz7qWqeeol/2QVSc5jhIIbFEhffXcRzIpiMBN4ijQcQ9VwqLJScI2mt8kP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419381; c=relaxed/simple;
	bh=D721kOqnMJgXW11UxJ3c5NKSoTFXExUb5Aw9fORLDYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQpSHzb6dTlRZIGAS0p4bvLQQduNm3uSQZUpyksbn2jKMq/7DXREYfzzH6/mtF3n9MOf8yU7INRAyUWuvplIxtUlgYrl3DoprEA/WvOIQfigMLJL38jCScFsobfxyc0QjeLG1kyi9HIqo2Ie7KLJHSw0RG4gHF062nDx4CIVPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=Sb+Jv6Tz; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Sb+Jv6Tz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=MZt2HE8eiO0uRLaoVeWG4Oj2x1b20jHkcdDTYTxItYA=; b=Sb+Jv6TzH9c1P6zdgMahAJ6etA
	09cxKjmAbDIjSpfti5nxypN9xZ/2CCaTTjiJ2W2L0/mRPM3uBcsi1WzD1jVSGWA90kzx7CSqTBhqG
	Vf9ElvCi4AIanh8oONWg9OpCi7WCI5saHLMmbrp1pgRHxZyKXQSl2Igtv2M7GyVJxa7qIf+7SXX3J
	4F3+WDgC9P/pE7OGbaQ24K5BSWv6ZFFS6a5qd0wHO5R6zUABuwuujQSuBitpOO5V6aj5Sklj74Ozp
	YvJtKu/Np8ALnNsgGyJnOBNKPv+xZB662LIvKnHvJGP9IAo8v7L0EXUPDsQb4TLjUF61xOIi1LKIz
	CgyBitTv5WeUt5DzcpwNTlm1YJHwRMy/imgcxPtVWMRc4IAqWx3pgDiwgVpDi/34NW9V36OmzfXde
	Q2y8hEU6Y2OVc24qwlAmbmcTkZhEbOO/p6zG8hcJGrlvD5CHnCr3o7h+juGjVufQczBevwSTg2Wme
	PsDlwgGcSjqj6gSb8bZmfjf8k5inTkdkoHNo9H67cRsxA5L/MIs4ZIOhstgAulUaKq4+fILR/Uzmg
	o4qIm+ExEb6UKPEeI3RdFCnJo9qaC91Ui3F3T/gq5n2MNFUuM9hTpMTn+LnOFIMCy+2t7+aNnib1r
	qsLChisCYyUoQ06/wAg1CFyxCiB60fvpxG9W9SKj0=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Remi Pommarel <repk@triplefau.lt>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>
Subject:
 Re: [PATCH v2 2/3] 9p: Introduce option for negative dentry cache retention
 time
Date: Wed, 18 Feb 2026 13:56:15 +0100
Message-ID: <3031269.e9J7NaK4W3@weasel>
In-Reply-To: <aY2cS77rIL-h-8il@pilgrim>
References:
 <cover.1769013622.git.repk@triplefau.lt> <3929797.kQq0lBPeGt@weasel>
 <aY2cS77rIL-h-8il@pilgrim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 12 February 2026 10:24:27 CET Remi Pommarel wrote:
> On Wed, Feb 11, 2026 at 04:58:02PM +0100, Christian Schoenebeck wrote:
> > On Wednesday, 21 January 2026 20:56:09 CET Remi Pommarel wrote:
[...]
> > Wouldn't it make sense to enable this option with some meaningful value
> > for
> > say cache=loose by default? 24 hours maybe?
> 
> That is an interesting question, I have seen pretty satisfying (at least
> for me) perf results on the different builds I ran, even with a 1 to 2
> seconds cache timeout, maybe this would be a good tradeoff for
> cache=loose being almost transparent in the eye of the user ? But maybe
> this is too specific to the build workflow (that hit the same negative
> dentries fast enough) ?

Always hard to pick magic numbers. But I would also say that 1s...2s is 
probably a use-case specific pick specifically for compiling sources.

When running 9p as rootfs you will also frequently run into libs querying the 
same non-existing configuration files and DLLs over and over again. So I would 
pick a higher value. Personally I would be fine with anything between few 
minutes ... 24h for cache=loose. For other cache modes this could be lower.

/Christian


