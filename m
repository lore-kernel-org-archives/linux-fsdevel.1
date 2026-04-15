Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8839BFE8
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237435; cv=none; b=UPAB1DICYXPOBzjn8ZSvoi/p4Buv3Mapwq0W2uuAYcI7moqXXQ2CuH0wj+UrNkYJjgvuIPIlQIZeX5k1j2oqTiFibehYU0zwMbBPdBnFfhz/dR4W6Bh7ANsEKemwOMjZ49NvBUAEdAJ3iiWtmNuztJQ+/j2hWBFL0WCClcZFj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237435; c=relaxed/simple;
	bh=Z0PFj83wUZxDbDI0Tl2heYx+wvJWiKxDfwKkJMwyGXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6daby8aIgCN3v2zKWRizvwKdiguesQgVRtPORaUEMfO9ElYQFsBQlgaB/jlEIDVQHYwMAqjDh1mOq6l0zO7xhCd/LDMGKNWI+N8DlIZSv2IKk7rSMnlxfeaIWWXF9uezkh/HFqesy804mKCyZx7+RcKArB2uBi5JUKDyX1BbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpcA7oIK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKe1+gT5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpcA7oIK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKe1+gT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776237433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kpxo+PDDK3DTSUbSbSohhwT8i9dWuHGnv9dNRZsuMyc=;
	b=OpcA7oIKiAqWwKsI2ykpBPxicBZwe3Atw1kif1vdFmGtKrOCsA2ZommJCiI7L4Jm/aMKSo
	3I0YmyCxrOI8GXEQBuzye1b64uNN5tpJ1iRBx8iWeLCtbI+0T3rYn2QI3T3n64oB/4oVTT
	TU1vq6cBbu1beiEVJUYIo2kwrCWUz+E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-D2In6BSPOuSGldY3-Hkqsw-1; Wed, 15 Apr 2026 03:17:10 -0400
X-MC-Unique: D2In6BSPOuSGldY3-Hkqsw-1
X-Mimecast-MFC-AGG-ID: D2In6BSPOuSGldY3-Hkqsw_1776237430
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8dd61e9d1faso1644093985a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776237430; x=1776842230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kpxo+PDDK3DTSUbSbSohhwT8i9dWuHGnv9dNRZsuMyc=;
        b=GKe1+gT5h7gW8ba/FTyibv+U7IOaJRf7bFrGCBsgwVkCDIw4sL8ne0pp00dqmZjaDp
         y/dGvaI+L9k3GhVJwK8EH1PrQKLLFYwt3X47tPLGZhIgiPiYVe4NIgH29DwW4q+l+teI
         Dr8si1QtsNWPGwukgD3yKe50SDONkDvt9a1EqR4vduYeALrDQbNmm5Gw2Dy7baUPxvmH
         3kTODpz9sFnksxUUVgp0SDA07i+0ivcRkpKmqx9I71celKmBA9tAlog9llD9bmMihd4c
         TLPpg3MDokt1iHFToxIyyPvd7v5Xp7Bey7YnexKr5cEhrhhivbGkVLjOCHMEkDgIVhQa
         Dg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776237430; x=1776842230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kpxo+PDDK3DTSUbSbSohhwT8i9dWuHGnv9dNRZsuMyc=;
        b=rgAAneH3cfseZY9xcTv++x7oLl1ulW5FzIPxrLkJY/7J/TEKN8BT89ZP2kmMbRPy+b
         SteUS3qeb4eivszU7J7f+i2ogYlSbci0vUH2OMpLswWrppLbb6+xbpRRk4W0wyi6ypL+
         rEHmYQY7BU/wAgWZvv9txHDFsg3CEIn7BsT9aUF4yfA7obctz8DeXj6oQhaKYLIgJZlC
         wx5AYTZWnFeEn5b/L+dH81fX5cQ2rr9CLvJ13XTrts+H3a8U6JhqIRicJIym8aqhdQSP
         +efexcSWuJOcPSJXzjaGwvApdcZMTGoT1DUl+87g9u17ri73eGQ+Y/b9DutWbPuT0Fdz
         7DBw==
X-Forwarded-Encrypted: i=1; AFNElJ+wHv41YEEtv7VlmED5+PjVKJ5fIOvHplzgvFWeDNCmOKahdWuL2MsnOInp3KETN9cZt+bPXX6F9OhWGLHi@vger.kernel.org
X-Gm-Message-State: AOJu0YygSI70LZqTNdXQ+wAC46xUn0dFHu4y2Biie9P+PB21CvGNc13S
	oknMtPITmT1mDFfJUwF/Vx/KC76ONfZOrr5PF20mbyCYzeblaDU7yBpCvIhxfg+5OqnYE1gDNZ1
	1RX5OEKcseyMViw9y8cz/YO8Ww7hGTXQhZ9Mmnot2tUQVw6ZmiGcr5bFXvA01sNOi3FU=
X-Gm-Gg: AeBDiesCXn5xXmLzPKWtCQ9pJx+fe2CrhVtH/VQvwcOkQfhTZJ+i0JBwzgTfesqqRFK
	xoUeL4j82Kd12eGhI0yJGx+cXac/e/RYkR9rHl7U3+V0zohwUMjFBQAtpLaO7svNME2VP8y/3Kx
	4DX+KqkFnX/TnxuYaNt1op5SrOK5CjAN34KpcSs3oT1YL+zF4OySvj4kW5rRsQZKkpo8EydfHhD
	nPLtEv4+8ctAVNFjjDan/ViUvLs7q27S1FQ+QK+j6yXfsndzn0vsfRbrRL8gljcxA6zbpmMQwVB
	WqHuJTJS0owcs9zkLOgMO/n3mZbQWC1YJuudFLby4VEA0M2nK1cM865Un0+QKoi/0xQm3No7Bch
	/7aKvYGlNM227Jd6mitsNxlgfI422CLqm+6O3m9g+3HYxvQ==
X-Received: by 2002:a05:620a:254b:b0:8d6:874c:a763 with SMTP id af79cd13be357-8ddcffa63fcmr2846137085a.49.1776237429991;
        Wed, 15 Apr 2026 00:17:09 -0700 (PDT)
X-Received: by 2002:a05:620a:254b:b0:8d6:874c:a763 with SMTP id af79cd13be357-8ddcffa63fcmr2846134885a.49.1776237429589;
        Wed, 15 Apr 2026 00:17:09 -0700 (PDT)
Received: from fedora43-upstream-dev ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33bc4csm58464985a.12.2026.04.15.00.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 00:17:09 -0700 (PDT)
From: Ravi Singh <ravising@redhat.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org,
	dchinner@redhat.com,
	esandeen@redhat.com,
	cem@kernel.org
Subject: [PATCH] xfs: flush delalloc blocks on ENOSPC when creating symlinks
Date: Wed, 15 Apr 2026 07:16:57 +0000
Message-ID: <20260415071657.23412-1-ravising@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating symlinks on a nearly-full XFS filesystem,
xfs_symlink() fails with ENOSPC even though space could be
reclaimed from speculative preallocations. xfs_create() already
handles this by flushing outstanding delalloc blocks via
xfs_flush_inodes() and retrying the transaction allocation, but
xfs_symlink() returns the error immediately.

Add the same ENOSPC flush+retry logic to xfs_symlink() so that
symlink creation behaves consistently with file creation.

Signed-off-by: Ravi Singh <ravising@redhat.com>
---
 fs/xfs/xfs_symlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index c4da624fb296..bf3cf23892eb 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -148,6 +148,12 @@ xfs_symlink(
 
 	error = xfs_trans_alloc_icreate(mp, &M_RES(mp)->tr_symlink, udqp, gdqp,
 			pdqp, resblks, &tp);
+	if (error == -ENOSPC) {
+		/* flush outstanding delalloc blocks and retry */
+		xfs_flush_inodes(mp);
+		error = xfs_trans_alloc_icreate(mp, &M_RES(mp)->tr_symlink,
+				udqp, gdqp, pdqp, resblks, &tp);
+	}
 	if (error)
 		goto out_parent;
 
-- 
2.53.0

