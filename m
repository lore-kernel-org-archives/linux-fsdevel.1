Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6E384CCA
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621684; cv=none; b=Y0H3xnEgLWR/8MQUBboPBEelH3dmIlRLRpu6VWKHBdtQiUuxtUUsQM63GYknNSo7Crb3pdE3sMI/ubzYLnnMLwTwqRr7RY/glnOeq3J11uifkpbpdGDTTu5LR69XYK3E+Jkgo3bDGRRBo2dyTkAmvhXufrB5tQWBj+dqQMAmFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621684; c=relaxed/simple;
	bh=rmASDDjzyu7ORP+REJJAPqpbg4Lkmrb9SobBQ2fdR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvwYwJJITWgevYZef7m9EzHR+9Ed7+5stRwUq8MenNI1Pbq+3kPBNbGpRr8Bb9aOFkFOFKdCiC3JYkiknofZaYrElymzFv1T/DjWEzP79TTuZ0CQr6oJLfA9TfIYKvAHhWjAWfJSJkjIUPN3uCAOIk7ezRsEaT4pMvEDEoam+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMnnxug9; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMnnxug9"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664c6304683so1983143d50.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621680; x=1786226480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmPK9JWvOViXyoDvMWnuptWNftqO/5jbHBuyoy5p9Iw=;
        b=ZMnnxug9XdWQ0aXvQSPCN2jWf+hw2NGNaI9rsERvZSxtiKGb4zMc+oFGf51JQt0eTo
         ngmYksGG9+iDAue1aGPDPVXT/bdWSYFaOsCl0F9aT06Q4M1tTiK+WrswQRDxYqSYxmKG
         uDq4Q93W0SVAB8dXdzOhKahfz5q5/HDeabMMVjWPrJeKwU8Pvq8ctmeDz5nQU5f3MpxS
         8rx0dnvWPfjc1b0j874DqBxATRVdprSV0tX3oNXEVkTinZLeC/hvKP+L3fdPq/EWLJhz
         Z6mmStYrX/1cmxkP+A3B2YudrR6I/nR0wKy07aHxBzn7OkqxqYi8Rb3ryVdAbEEXzaE+
         10gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621680; x=1786226480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CmPK9JWvOViXyoDvMWnuptWNftqO/5jbHBuyoy5p9Iw=;
        b=IIxnMFZ1S61lkB/SwVtvH55okSmo7fEvfMeqif2XLIdIZKd7mOGuQq+0sYweE2HWxW
         SYQ+PokSa3gAhNvRVTy+tKfnYUUa0C+bu9evMndb7siioJVnYh5O1i3ZxqqF4vJzzaT6
         KbMJOolp3UzmMRwBhkKYl+1WeJ/8wSquxo02Qx/m8z/Sw/TPwlVzrhnpPOypGQlva+xz
         PfiNA/QL0Hl+b5afZwhKKY8cd8oCRSieBdWQY47lH7Ja8it4S/CCVusucwaMa/5JWdGV
         41kPZRfG+6BcokcBZOKk2nztucgJyvVb7sQKtP04h17rXGueV0hWtIahLp90mivtFfMj
         n8Cw==
X-Forwarded-Encrypted: i=1; AHgh+RoLJrzTrvD4984TjU+rP+TlnUo8+8q2JxfMjb8A6YzyXbWY3xvRrKD0SuhPt+7kwtZ7dKhZl1QcjSOUOjOv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QDTiogRsWDhT1j4Tz6MvhWIFrNzNLX6QaYwItKqbzewJw+KO
	c3Aux5Uraf7HoAu2IsC3v0bVkQqHn6kpIfSN95IJgy/PirVDZE2ols4f
X-Gm-Gg: AR+sD13ZE6JqcuO18jfhVGur97y+JpLD/x2aX94sKUiFQB0ab/jv9za537qhmKCl+6K
	Stoe46LuxgRETEHYVrmWURKo7CdjWU7s+TDZpzp51PmayC41Zu8ZYKIdecZrVbLhnHMOMrVsq0Q
	qo4S4c7UOV8Jz8vAZAPNltMHk3tk/wP7/NOaPbsa26yvNRxDVnvUH9CxO4/ILlEVYvzI9qo/4eF
	bYreZZ36Y0Df+vzS4O3gLiJuS7i9UkjRUzPpNcW2QBh+ADvHJlRZL5dhwBmZkPp/uAUoP4qC7t4
	MvDQet2w8TTGQG3z8Nyi9pUelekCrLxc6ZdIh+rlgxfy99ypmIwR8i44RGelBY0x9hiUD1j5I7K
	PAzkthCBSpXGVUCrcmd8OVD6G6NTQ2xdqkMmxDiSaXS6yShYavtawk3PrX/fCosoKVwvuVhNHZt
	zPjsgbLiSzQQTSbbVVqQDM7Mx1BkK5ebTpD1p0h/THV6Jp2h9Mv9Cs43v4A+XQukJPxzoIOYMCa
	XaFwTM=
X-Received: by 2002:a05:690c:dcb:b0:81e:d009:1956 with SMTP id 00721157ae682-81fd4a21566mr79336867b3.12.1785621679620;
        Sat, 01 Aug 2026 15:01:19 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:19 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 07/19] adfs: check for a directory write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:51 -0400
Message-ID: <b688ce1ef8805684f8c529b8934406ddf6e34da5.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adfs_dir_sync() spots a failed write by testing BH_Req together with
!BH_Uptodate.  That relies on the write completion handler clearing
BH_Uptodate on error, which this series removes: a buffer whose write
failed still holds the data the filesystem asked to be written, so
declaring it not up to date is wrong and makes callers re-read it.

BH_Write_EIO says exactly what this code wants to know, and it implies
BH_Req, so the pair collapses into one test.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/adfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 11afa9e157aa..b8cc6a697a05 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -191,7 +191,7 @@ static int adfs_dir_sync(struct adfs_dir *dir)
 	for (i = dir->nr_buffers - 1; i >= 0; i--) {
 		struct buffer_head *bh = dir->bhs[i];
 		sync_dirty_buffer(bh);
-		if (buffer_req(bh) && !buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			err = -EIO;
 	}
 
-- 
2.43.0

