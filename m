Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320711;
	b=uwJgqjq0F1asn7Poh73sl+UeCL/7U03EXHEsw5HL8rL84UKz7LGxXOZouAjhA7cr3Y1d
	 PHaaPzBMqeZdARGS7Nh667g7aysQhtv63JaKZnd1uAn4kOHOIN1PLar4sz4gGCIpGjGxO
	 4E4PmVlbpGv5d+UJJHGVpuWj238fluFG+f5jCaG02RCF553eEbm+GxaL0ttubsMdACeyc
	 6BTUSBnE31NuCyGAvBbQm8CnhFOHjAP55UHNboUnz5L0q3tUhbBbrgT9gXOS9xFIGmZ8q
	 SFT1LShNpcUKXmmcUmq+bEpopFyQIdAX0bjkaVe4AtYKOn7OxJ8NU7dYnIEXAib3ZsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8zerBigyv9mmzg2Gjo9e2dqqPP6k5FgIy3HAg56oVSI=;
	b=zcXwx5JH1utMHUPAdwpp/7mcqTQY3MeVN/n5hdxi2dMn1G95lFQUrFeywddlyJH8fJVG
	 aMJwud7E8pcIevC3mRCa4oZmRdL0kERrg2rW+9KWfFtc5eOK3rOwJY0C410VnhqahG+A/
	 AVxFjrCMkFCESwBYnf1SbuZMtcGufrgEdv8Jpm1Qf0Ces82B02Xy5mK35P9vJz9xePGay
	 aq/CFW9dZcDR9Id8mAGz/f6kqdNTA8IbISPnN5BghYeu5V8yRziZ25+w2k9YJE4HXdmZB
	 pY9e8M6SyAaPGu1nuTa/z+Rfz4zYmBxllVMVfSyxGpKQGhJUyhuDhaXc5EqZZmJf8OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="gMvp/4tH";
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFD60A6F6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAAFD60A6F6B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=gMvp/4tH
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f3c8958d5so235730485a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794320710; x=1794925510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8zerBigyv9mmzg2Gjo9e2dqqPP6k5FgIy3HAg56oVSI=;
        b=gMvp/4tHZPlWdcSsmWMjI/yNPB0fufeNNrLxVB2i4TwxZDREnjr76w0+nPjrm5vLwi
         D73U8xUzIq7iEeAKifVdrzICeIAZdmR90LYDol0kkboU4Aoy5mGJrVTiVLiOdLoq3Wk6
         z11Vdty7lHJiMDF9CZE/Y4eDs7V95i2wlK0hFrVqxS1vt01ZGWaMGd+o4DwQvtetE0J2
         xDtw8BsuPSAXvc/I08lkJ5DVlSoLJvDOoV1MJi3nE80CTivTmhXDGtZrJeBUGPHFavOV
         9lg8sPSkdFYX/+uMFzqAafvq4RVusxDTbiD+McY56ltl3YmQ4W+ZAQkie9X5/E/v2Axf
         +7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320710; x=1794925510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zerBigyv9mmzg2Gjo9e2dqqPP6k5FgIy3HAg56oVSI=;
        b=ia0216Q/ZbmoLnRqql1XjbdEJx44lZgJ2jwEvLv7sp65Bn5MMM4KrKKeC6YnH/bMKD
         sxst608gPX63kBGEh97NnsWqbcyuVTOaKgwoutrll3cGJ2VY4hnddrsef/rmuZY09TpF
         xyxWmT67mRquftXpY6iGTIZyBfZS6JOQU+lYBFJfoJCFEw7eDsk0yYDgX119bt6KcZIE
         8Qv1CqxR1tPlBy25TzjSsijAuEvBqeHpYVXVqq5Ph/EuinznVBb2gpWzTEadAlqEhN0z
         Apnps3hCHwqNMmxsyscvK3tqx6RLTS/faDp3NfiLi9a2z2QnIxEMvQ6HlJUF+TyaEYhJ
         vIPQ==
X-Forwarded-Encrypted: i=1; AL+hErEOokD8VytWGTbDBGItuBwApmnu8tFakGiN3pUWX7EgVslvGdwdoxqil2Z80/+ND/sCKQIE2UIXWq6b8oS+@vger.kernel.org
X-Gm-Message-State: APuU4Z9oVqvqxWjq1gBHpTyQc2FxB7pvlq+Yydu3sQZX62IQ6Wf50vl6
	rg0dyFqYBNs4giLUVYDLxZMN0ho0VRPrJBT/79p4SYMbpDg2hBinpVEunTiVhZavVJ0=
X-Gm-Gg: AYBFou157JsVAmh9uTbJVSLF5NXfiks/3RYeG7JLVnj7kPjUBuyoe0UTjKHuBQE0nJz
	C/kLJnpyx7lRyufEG6d72esIFh2wlk3l3lh1Eb/O+38frk7LAyodBwIX2ocoJjdNv/DJ5giANIG
	q35pUriwZIOQCe5I1j8mpWP1zzZsmD1rtb/+3D3lEEwdXxgGDLAt+LO4UF2JIWYIcm4V/hxRYeV
	ZqRW0nNTHEQlZbA+EEQufOm/A8t5yilvdQReTXzdFC5e0lnLguEYHjLrUF2frcVGlA/2LWBTbHH
	OQSKpTYxQpt/uST/O221/Qqi3ZLgoUncgVlyC++YiCWpNAwBSp9MuP7gLsa3N0d9E07KeqEEmjJ
	ZIMhzo95tZDjz5l9Kj6DR1CwuturedlvTPzmrEqM4rsEbsLo8eexw2hPfQpSB+kDi6Flbz2VYWX
	xd+1N9Ww38BMUC1IWv9rs5QYCJ/BM/4/IJriRPKYciYvaSMG3yoqSVoq3St6PiMGu1iOUeyglTc
	GgXlD40eDwu4L80Xz5zVmiUFgGGMOwAbOeSAtXakPIIcnjtNSKl/KrgAnVeEMl9ROTEs6q6YNoT
	+WkB7xcwhaNdvbuB8wJqBA+WYgfR2A/TdmOrWjyVbP0lDxE2a33qBf+Pal3RQDsQTjU=
X-Received: by 2002:a05:620a:45ac:b0:943:faab:a149 with SMTP id af79cd13be357-9479f38f7d8mr474237285a.63.1794320709592;
        Tue, 10 Nov 2026 06:25:09 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e770d7csm235081585a.17.2026.11.10.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:08 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 10 Nov 2026 14:24:54 +0000
Subject: [PATCH v6 6/9] ovl: cache dirty overlayfs' inode
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-b4-ovl-containerized-sync-v6-6-43d1be16a4d6@toxicpanda.com>
References: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
In-Reply-To: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794320698; l=1773;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=4vtTge6/ThBXumR/B3MN7k2/gMZpZtKv00zfzARf7Uc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHMUwCVvUHJZIqDJQPoatfq/63xIDsZ7l1dryd7bHmkdczxNnDK72RycPGk1V0k6C1rUbAWZrUU
 LCp+SndZgEg0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <cgxu519@mykernel.net>

Now drop overlayfs' inode will sync dirty data,
so we change to only drop clean inode.

The purpose of doing this is to keep compatible
behavior with before because without this change
dropping overlayfs inode will not trigger syncing
of underlying dirty inode.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
[josef: also keep an inode that is under writeback, rebase]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 41d0d37accda..ccfbaf9d8797 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -388,11 +388,27 @@ static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return ret;
 }
 
+/*
+ * In iput_final(), clean inode will drop directly and dirty inode will
+ * keep in the cache until write back to sync dirty data then add to lru
+ * list to wait reclaim.
+ *
+ * An inode under writeback has had its dirty flags cleared, and only I_SYNC
+ * pins it.  Such an inode is not clean.  ovl_write_inode() may be about to mark
+ * it dirty again, and marking an inode dirty that is being freed has no effect.
+ */
+static int ovl_drop_inode(struct inode *inode)
+{
+	if (!(inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC)))
+		return 1;
+	return inode_generic_drop(inode);
+}
+
 static const struct super_operations ovl_super_operations = {
 	.alloc_inode	= ovl_alloc_inode,
 	.free_inode	= ovl_free_inode,
 	.destroy_inode	= ovl_destroy_inode,
-	.drop_inode	= inode_just_drop,
+	.drop_inode	= ovl_drop_inode,
 	.put_super	= ovl_put_super,
 	.write_inode	= ovl_write_inode,
 	.sync_fs	= ovl_sync_fs,

-- 
2.55.0

