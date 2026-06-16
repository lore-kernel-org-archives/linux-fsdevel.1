Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68C30BB9B;
	Tue, 16 Jun 2026 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601865; cv=none; b=RAbvRohy+oK8Qk1k0q+WuoMM9R3pN33xqijMiicbbsuY02VEvaq5v//jO8hRvbPBsUDCDVUC3iZNAHXs1uN6mBRmo+i5cUMOVNQceDBDWrK1aDfgVCnkcXHe3zoNGF/L0Qxhw8MX7Ia//Z3EOb7/+TfMLgj41I0bKF5lDv1lO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601865; c=relaxed/simple;
	bh=f+5UAMeXKUDn3vRAENHOtk+dfXeRhq5JMrss3epzLW0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Y027bydNbd4S1t4n0nIc18+Y+C2bOCEsjYkNUh5XHuTAE5OHxyNCVv/xoX3e3JAnOHFMFYNood/9ftKbfq77n7Mx1YkyJ+rgYwvpksaR0LCbHZ19/Lu806HYjgE4ijGVuXTQro7WOPljdsEb+A6qEU5W7zhcVJbf4dFhypvKnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Rp9Is+Dv; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Rp9Is+Dv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1781601856;
	bh=s/cONQDckJCAe97VRoIStGE+bfQxN3XwdlwGD4i5YtA=;
	h=Subject:From:To:Cc:Date:From;
	b=Rp9Is+Dv2JWFU+QXP0pwJXBqwV/rDQrotU2aiI2urwxq/qrbE2X7p572PmEPei01Z
	 CwfA5w5+pvNvDzLn6rlP74DL4PEAomIlojjZ61QHRvyblZ9cU0jNmOl6jaTaLG/9nW
	 1UyeOjsobtSpt8iFUqKLkF1agQjJsyElbuItL+rE=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 50F9365982;
	Tue, 16 Jun 2026 05:24:15 -0400 (EDT)
Message-ID: <cbe95c15d2760f6fce8eaf207c969ce8fd3703aa.camel@xry111.site>
Subject: Ironic visualization in menuconfig for NTFS_FS vs NTFS3_FS
From: Xi Ruoyao <xry111@xry111.site>
To: linux-kbuild@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Mingcong Bai <jeffbai@aosc.io>,
 linux-kernel@vger.kernel.org, 	linux-fsdevel@vger.kernel.org
Date: Tue, 16 Jun 2026 17:24:13 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

In the Kconfig for NTFS3 we now have:

config NTFS3_FS
    tristate "NTFS Read-Write file system support"
    depends on !NTFS_FS || m

It basically means some sort of conflict between NTFS_FS and NTFS3_FS.=20
But then menuconfig is apparently puzzled to believe NTFS3_FS "depends
on" NTFS_FS, and put NTFS3_FS as a subentry of NTFS_FS:

  =E2=94=82 =E2=94=82    <M> NTFS file system support                      =
               =E2=94=82 =E2=94=82 =20
  =E2=94=82 =E2=94=82    [ ]   NTFS debugging support (NEW)                =
               =E2=94=82 =E2=94=82 =20
  =E2=94=82 =E2=94=82    [ ]   NTFS POSIX Access Control Lists (NEW)       =
               =E2=94=82 =E2=94=82 =20
  =E2=94=82 =E2=94=82    <M>   NTFS Read-Write file system support         =
               =E2=94=82 =E2=94=82 =20
  =E2=94=82 =E2=94=82    [ ]     64 bits per NTFS clusters                 =
               =E2=94=82 =E2=94=82 =20
  =E2=94=82 =E2=94=82    [*]     activate support of external compressions =
lzx/xpress     =E2=94=82 =E2=94=82 =20
  =E2=94=82 =E2=94=82    [ ]     NTFS POSIX Access Control Lists           =
               =E2=94=82 =20

This is really ironic (some opposite of the intention of the depends on
line) and it can easily puzzle new kernel developers into wrongly
believing "NTFS3_FS is a extension of NTFS_FS providing write support."

I can "work it around" with:

--- a/fs/ntfs3/Kconfig
+++ b/fs/ntfs3/Kconfig
@@ -1,7 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config NO_NTFS
+	bool
+	default !NTFS_FS
+
 config NTFS3_FS
 	tristate "NTFS Read-Write file system support"
-	depends on !NTFS_FS || m
+	depends on NO_NTFS || m
 	select BUFFER_HEAD
 	select NLS
 	select LEGACY_DIRECT_IO

but maybe Kconfig should just handle this better.  Thoughts?

--=20
Xi Ruoyao <xry111@xry111.site>
