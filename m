Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8A3932D3
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251594; cv=none; b=OXaBL5Z0lNWsdwiBjcbD+voQrly/7j51xsLZuiERi2dnANTVfsEbmjzWE3imUZMWzYaqOuH4hAi4SlHjLx6hOj03CmNVAB5zPgXTgFi0OUPvRmjHgwioeUUrwBnv4A8IxDoPep1N9ybtOgz+dmtqegyTbpYfAkoEErLbtwrBskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251594; c=relaxed/simple;
	bh=+7BJ1ogU0JFbnVIXoaKvjjkF0neuKWvB0SAPcIB/oq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBvhWmDYL30CxEcDhnF+Btr6H7yBwVWK1KJctftqT46Zw3wnxbbI8VmlQUSrvA28u1rZj59vo/K3ed0TH1I+uspTsyzOCQR5y6XBDMw2c4DlpMl4/OHAdWSIfMpW+/ZGYPizMm3lx7tw9ZJMDHatyWKzR4gJi1hOAahrZ5SKUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=VyWV1Hkh; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="VyWV1Hkh"
X-KPN-MessageId: 4d461328-5d1d-11f1-92b3-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4d461328-5d1d-11f1-92b3-005056aba152;
	Sun, 31 May 2026 20:19:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=T4Ix4vnXQIcxzLjeDEVNR9mQKii3/QrnaG7EOxqFwgQ=;
	b=VyWV1HkhrN/72F2wK22gb0rfmDAx/wNgwTzFMJ5M/tvll0qGXYA69eL/1THoiT1iL055ktg9pWIDW
	 B6uU5DLDACPJps4EsoT6gfsknwo4Cgux9UkPMG2EA1KvRw+7qSycCPRfzFr8D7QRACpHvP8ClOzXDJ
	 zce+YEwr69V4TFyIr2+69lrt74r5vYwzOdsnbIiLV8edsvuhiEaziaaMckUiknKslXpMCHFPLz1d9k
	 DWwyaHp0NlCbtXNW2xuSKTKGDshDkbwyfATl+x1XCqdBKqmOSde9Q96k9U3lhQVbG9n+IfQKkop5B0
	 5r6Xoi10ml7VaKSFZqgPf9VjFuV7UPA==
X-KPN-MID: 33|weWFwkD64ApSqR2Hw8ZJ3Varu/pn5rwxVau+S/jJx3kkrqcxWcD+W3yex8LZCTP
 xaQe55rxwX4O2xsXRHNL3+N2b3dE7RrFTI4t4W0l9JfE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|X5cdvvVLCicq1nayklEUPbm2J6R1vS39VHuS2PZyAUhfqxDXRZDgi/GKoQmOQUk
 xlCO7AVn7/FuB7jKXHuGHXQ==
Received: from daedalus.home (unknown [178.227.141.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4d10d6df-5d1d-11f1-8011-005056ab7447;
	Sun, 31 May 2026 20:19:45 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [RFC PATCH v6 1/9] fs/namei.c: make lookup_last() use trailing_slashes()
Date: Sun, 31 May 2026 20:20:37 +0200
Message-ID: <20260531182045.171711-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531182045.171711-1-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small cleanup to use the existing trailing_slashes() function in
lookup_last().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..137d9fffbe80 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2777,9 +2777,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	return s;
 }
 
+static inline bool trailing_slashes(struct nameidata *nd)
+{
+	return (bool)nd->last.name[nd->last.len];
+}
+
 static inline const char *lookup_last(struct nameidata *nd)
 {
-	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
+	if (nd->last_type == LAST_NORM && trailing_slashes(nd))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	return walk_component(nd, WALK_TRAILING);
@@ -4524,11 +4529,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	return ERR_PTR(error);
 }
 
-static inline bool trailing_slashes(struct nameidata *nd)
-{
-	return (bool)nd->last.name[nd->last.len];
-}
-
 static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 {
 	struct dentry *dentry;

base-commit: 174914ea551314c52a61713b9c4bde9e42d48073
-- 
2.54.0

