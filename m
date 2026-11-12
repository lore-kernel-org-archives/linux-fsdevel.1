Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448251;
	b=UbAA8kMldlUB/pd9rVhK2xxo3X31Pftl3Uh8FUe005vtrnZLOa6iMZDVjcl376odHDuO
	 6fN79LoJMuZ5aCn8GL0ais09exJymin5iXXCnyGfEwhS3KpYJi6iPDC7wXjBDQ0E57/s8
	 C6+zJkUdoQqIBP9zbe+NCcn7+H0dJ0mOuvBSZ2oWXbRzwzk/YOXIUEbXCVOSFbBlXFF2L
	 vVjQQuregVtgl6tHXcfXxiRc07uRIRvw+rj11ICD/sNW6B6mdMsICeUUIikrgRYWK/zQl
	 J3SsN2z8oj3Ma0ylbAmATE7KXPhzCCmMNK39Dv60VGE4mqN1c6G4xBH2dwVTOKTWHJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448251;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rbhcvAWt3CVbL8hbLS8Z2xAzLk3XxwJpiSswVlOIL/g=;
	b=WEcmdEUyu9uBQlwv6raTxxb+mYVXxvu6Q8T9PyQnHmaueQO7b3YgIEXSPwrEtDHiEM2u
	 W9CT/FmgQP/Sz0KcTXRpWKXOVuILPzAlbB++kwEJgWNMnbhDd3eCArFI/9e9kf35weNA2
	 T50JGpwUCcOQwkfHRjksHVy7FTwV0niS6HEHNwqckG/AiJzfv3IUViUXELhbIhIUT2IK1
	 Ty1Bo4GtNUCnaWSxK+GoFIRQ3voZsaYKy7AdiU5sf6kvEO2ejJO/nCup6TGloWRjFHY2T
	 9BhZgCvP5ad/BN+j2ILSLQdx0vmDaiFzRnBtM4DyekW9U8xVkRaW60wp7nPs6lSaKIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=MlW83o4r;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C432606A32D;
	Thu, 12 Nov 2026 01:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C432606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=MlW83o4r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=MlW83o4rpQT+1iNfi0HAKP18lvZftuAym7sDu1vdKye3nzV9XGU5CeMNyV3IFHcn6XNY/MsQ05Wd3
	 XiFJns6F0LjjSrNFKe59WFhuoLkpX4H/BDRtGNWaU2H0Z8eVTMy+eG75zeKl1nYovPp+EWcKfYwDSG
	 YZJHE5+uOsRd2C6U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af51b74691-a7fc5;
	Thu, 12 Nov 2026 09:50:48 +0800 (CST)
X-RM-TRANSID:2ee36af51b74691-a7fc5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af51b76d7b-ee05d;
	Thu, 12 Nov 2026 09:50:48 +0800 (CST)
X-RM-TRANSID:2ee46af51b76d7b-ee05d
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jack@suse.cz
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH v2] buffer: Annotate the remote buffer LRU occupancy check
Date: Thu, 12 Nov 2026 09:50:47 +0800
Message-ID: <20261112015047.114119-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

has_bh_in_lru() reads another CPU's buffer LRU while that CPU may install
or invalidate entries. The local BH LRU lock does not serialize this
remote occupancy check, which KCSAN reports as a data race.

The check only decides whether to send a drain IPI and never dereferences
the sampled pointer. Mark the occupancy check as an intentional data
race with data_race().

Fixes: 42be35d0390b ("fs: only send IPI to invalidate LRU BH when needed")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes in v2:
- Use data_race() without READ_ONCE().
- Drop the added comment, as suggested by Jan Kara.

 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5d3852b726d6..2d2d61495b4d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1437,7 +1437,7 @@ bool has_bh_in_lru(int cpu, void *dummy)
 	int i;
 	
 	for (i = 0; i < BH_LRU_SIZE; i++) {
-		if (b->bhs[i])
+		if (data_race(b->bhs[i]))
 			return true;
 	}
 
-- 
2.51.0



