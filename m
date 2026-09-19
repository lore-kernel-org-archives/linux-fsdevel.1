Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9E2DCBFA
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856756; cv=none; b=LdxvJksJfxThVDWzIbRzsqZQ4xOJ0BGoe+rzGd+g6ZLUbjPnZnDI+o9Px8Lpv8JqXmtPMNsIkRZ6ZDJ0/cYv6Cjf+3Z+MGxLdg+j/mLPga955McRXXI5Qfa5UOiCa4PpxMoHo1CthQQAQ9Ox4VIcgW4Wi2zL5xCj4Ojn8JIzED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856756; c=relaxed/simple;
	bh=faL+bR5mJnSWT26nhaPYUm2+3mYzOwFTDhie3L0DR5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaRaek8LpvgWlHnBACWDnspJhxqadjJPfVUjzxsNtpE8h44przPS9dYte1H5ecbuNILDnHT8EEdL8rWocUZ5C0P6fJXSWJClEBpaG75cfgvGDI4GuDjLRNABCHhGSXqvv87Nfns2qbOJDMwBZWlK1ojjIHfjME637d6IQ5LayRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCXXmqLN; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCXXmqLN"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1357233a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856755; x=1790461555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UCU2eYD+vuETO4K8lnp/r7HglPCO3ep+/mQxmmKXzzg=;
        b=pCXXmqLNU1Y4AqX3xn8fjGN0L9QsCYRAODVJn/VbuOFTTiJPV0Usdoc2/7uolEylwK
         Zql0cQK3uMp19FfzvdmXi5v1Pe0+b+JFk6YzYbAuhKCojTLwzpSRcyFUdNgSy32f9txl
         vh1RpcAUlu5UyKp6gjxes9X01+qN5Bv9DwSe29nneHJ+WJDVMgIEeQbB/1Hvw34HY9TM
         kH9uYTU6U2LulzHsbWy9YWBMlpQhJxWmCxZepZrwrWAWIXMsntS4npYZGifJc2j5Lqru
         RQXnWBXegFcCCPK3QI2MHxAAqE0z+Mw8Sez8EumPfA3EBteLGzyQO3MB9Njc6CG7L6Jh
         fDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856755; x=1790461555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UCU2eYD+vuETO4K8lnp/r7HglPCO3ep+/mQxmmKXzzg=;
        b=OOGYmntl3xk8AvzZ454ox44BYLefQ5cF8Cisxt4a8jIUsQ5Sz1TdNxOS9KM18mCuTo
         IUXSMqaUIfDRUJUf4TbuO6rCR2XMKQM59aaKCBNR6kr1dugAYw8zS6boCWwimVSWlyuE
         6U4Op9WoKjUey8f/bFO9tKAnK2ivgNTrwtHA++zXwyRIW3vhjpsvvfy57UC5er0L7Nhg
         N8MX08rl7jo/fPEhoF2UOIDKnbVP340X3W5ndh49qUT+mqVTadlQKwjYsKPRIvE9sPDm
         FYGMZeZhvvffosK2oLZGfaBpUDwfDSj5EEMKj6jnQvVZ7AAvqLGmF/gRHObkfJ784fOp
         fbaQ==
X-Gm-Message-State: AFuF++mhaG9u9MlaFSlGxO4hcBM3Gac/m9nQZdmKiofZx8V6/4hNAoJf
	ZiQKqx7fht2b2r+GFc3ahjwpQB1TgCDxgKiZVvY5vcRB5zMP3NBfz2tu
X-Gm-Gg: AYBFou0hzwNuN2R8NOJ9tf/qxWUjGhj8XBjY81vzxO4LkHGQbsGB/MKy6rU+GWLGmFq
	d6wPinAkCRfgWIP8lOWeGYB8NeHT63/oZPkECYSP8QZCa7ux/Ea2Or1RbkaagvZUyXv+VZawTrh
	CK+amcAyKUoCGI+Bn+IO5/cER1SyerMLc8fOELEz/uDzWwFj8o/+SJg+D3y5X7QX8Ju3Yez8c64
	Cea9+uC9iMqneo8Ml3eogtJirpfvBqZlrfyMZXymNo1H3U3V7n70lPSlnSMy7qCqz4orrxgDIhl
	xvC9BiptRQ+k5yR3rn9GollK4rWhTMsPI2zo+UcOEBsjuhenFh7UqyrlHm8PpsuCbsOAFZRVpMh
	sMBZ+7urA7HtplgGNNOssJGTtSCs3QZhqMQDJs9X8Ktlvc0AwL4wxKWs7vVzJEmDQeojCATh1bF
	UZfmAt/obmUnVqvuxae4dreAvgOwHvSzpkgtNJlinaSlyz1EEc2sAsCkROzi5oLPfP6fn5sDuwC
	FjHQPvsVv7YHoW1LeYgCt2En9k9grUTY7q7KRlav3Gf/abmUEiT3hy+jNerRdNl9/5iy8HAgWuC
	6DeFMCiYOQ==
X-Received: by 2002:a17:90b:3e85:b0:39d:fe64:5725 with SMTP id 98e67ed59e1d1-39e54d37ademr11329220a91.5.1789856754923;
        Sat, 19 Sep 2026 15:25:54 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb372b7sm6363277a91.15.2026.09.19.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:25:54 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jack@suse.cz,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] isofs: reject short directory records in isofs_read_level3_size()
Date: Sat, 19 Sep 2026 22:25:52 +0000
Message-ID: <20260919222553.3792320-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In isofs_read_level3_size(), check that de_len is at least sizeof(struct
iso_directory_record) + de->name_len[0] before advancing or inspecting
Rock Ridge extensions so corrupted ISO9660 directory records cannot
trigger out-of-bounds reads or infinite loops.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 337836a0a170..6007439a085a 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1173,7 +1173,9 @@ static int isofs_read_level3_size(struct inode *inode)
 	struct buffer_head *bh = NULL;
 	unsigned long block, offset, block_saved, offset_saved;
 	int i = 0;
+	unsigned int empty_blocks = 0;
 	int more_entries = 0;
+	int ret = -EIO;
 	struct iso_directory_record *tmpde = NULL;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 
@@ -1205,9 +1207,15 @@ static int isofs_read_level3_size(struct inode *inode)
 			bh = NULL;
 			++block;
 			offset = 0;
+			if (++empty_blocks > 100)
+				goto out;
 			continue;
 		}
 
+		if (de_len < sizeof(struct iso_directory_record))
+			goto out;
+		empty_blocks = 0;
+
 		block_saved = block;
 		offset_saved = offset;
 		offset += de_len;
@@ -1246,10 +1254,11 @@ static int isofs_read_level3_size(struct inode *inode)
 		if (i > 100)
 			goto out_toomany;
 	} while (more_entries);
+	ret = 0;
 out:
 	kfree(tmpde);
 	brelse(bh);
-	return 0;
+	return ret;
 
 out_nomem:
 	brelse(bh);
@@ -1264,6 +1273,7 @@ static int isofs_read_level3_size(struct inode *inode)
 	printk(KERN_INFO "%s: More than 100 file sections ?!?, aborting...\n"
 		"isofs_read_level3_size: inode=%llu\n",
 		__func__, inode->i_ino);
+	ret = 0;
 	goto out;
 }
 
