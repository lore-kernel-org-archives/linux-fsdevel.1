Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369149;
	b=M5JKOL4k3sPtOkuWzVZYMSXetIBUESW2qD5zRapQOd5iFEIbYn2IMmhZYRTiKQiKVb8n
	 Of8/JTO+o/s7cN8y9UiR7sHRjdmAoqk7xBIM2hFZnryeojA4tnadT4CCIu3I4xVLgsxlu
	 Too4VfzVT3QcdV+wLAIiF4vncxVtYi6dh+nT2vX8gK41aAUb83QYDO6r4DjKIpkMS1OtD
	 nz7DMLSWV8hNzKEO4FnBtnXbr2vMLFfqys3BYg6/NuoXhh0dn5Ihol8ydbe26yNYgxsXx
	 sRQEPG5oKKmDbh/o5BnEvCHtK8IJB4LXLOsLdRsalI2jFdm69bDdtphHvNjLGD4mQVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oZqxfxCdSbzmJglHBrJdlpgWa99EIvA0QZBLWLTPi0A=;
	b=fT5sqVdOGnLGB5V1I79XWm+xHM2I+9A1Dd+u3zI4a5I8OuUMN1895d3/ukVHy/v22EWq
	 IIlQeBwLjVbcc/2aIUJTUrkWdCY1Wlh6AzU0OzQ6oXgsdstSQIjalpY2hRMMbUQ5cJ/xa
	 BhUsWkpmqmi2wGBQPJqTkoTv9EVhpCKoUsiMySeFTimKX9rzu0KRxn0ALbrguGCzn6c7y
	 27DpD0NwrehpeOOyRhUgd77mVUWG1nFOdUSZFStg2cphJecA1QNFEk0ziy9TbMx1wSE71
	 FSz4oNujPtP5C2HrH11YVA8XDEE+BQUeIdtMem4QOOnqQTQkF1V0enelxZraP57tn5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nCathxk2;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FC606A333
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 14:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A1FC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nCathxk2
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso296562b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793369149; x=1793973949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oZqxfxCdSbzmJglHBrJdlpgWa99EIvA0QZBLWLTPi0A=;
        b=nCathxk2yW/DR+AF0NaWv1D5zAcamjKUJP3o68x0jfU2mPSdyKkw/lJpMw5BOWjrGM
         rLpYZAIQiZuh7oQ8vyMSZgh7pFaKdvUxMihKzLVSXBXOWHoMcxvF5fWsgZzolU8yidEZ
         BPZYKUpFGnujUit7wgTrzWkwUyF+1o18LTdQW7g8LuKuzXbMsfpxvC6YIcSyE8loZ+mH
         FKGh7pq6ageKRMKjImXs1UpJMpIXkXK7WYsBmjFI7KLokBEVR6fQYW9i81foY+f49Hp0
         z+NWmrv2rL5K5/HvfQCHFDwrKJbkXHUk1ObI2xNEybtOo6P3FYJrQpZ9Kb8gMCQPO5Hw
         MOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369149; x=1793973949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oZqxfxCdSbzmJglHBrJdlpgWa99EIvA0QZBLWLTPi0A=;
        b=uXBNgs7scmTioCepgskdFhXl35mnCZwTLc+B76u/iznl4F2aqi1rROV88ILDoVFXy/
         wLWZsMViP6TZD+qNjb/rr3vvnjrQY8W8SGHDAlSmxBKNzIHgh8vrJ81ZrLyWhwlN8pdj
         LoTD+BwCqCZJAZ5UzSni0woXYpkvgcoz4frdWpwkDf4jd72ik+YsCkqTDvwusUP3UORY
         lXVwwCGoeIeBffDAmcprHg/PcYlW4+cE/ThuY0KawldDOETOq8O5bm/Z7eRP4jSww6GB
         bZY0gDrjmU9K1/pT3A3y6nvVMS1IzbdInSu5fhKoYTAd8IBqDjyHtvjeB3jjim4IWAo1
         SSwg==
X-Gm-Message-State: AFq9FYKQRTPEZiAXA+K6X+bSUnWzZ8XawMfhsEw0EsOgkN7jCSHQDiq+
	kHr/rMGEgagFF1G+gUbsTgjebhTQjjJoE2MwMlpolAB+xyMYjwqMCB1G
X-Gm-Gg: AYBFou0BLe42kqaj+hYKNNZbeSdySI+q54TSogwVyJWjtyi1DSeVLQCDKzBjeQmVIwX
	JnzFXYFuCYEJOuQ2T8gvU+NHq8GMWwiXR8L7YS5+3IDyF7kqMJYzl0B9LpjusQoL1ihX/FF4UOF
	ejonxSuda8lbwLfoN74gxx396ZiBlWRdaFqq3guVOD+RHA+HR3CLQATydwa7DaWT0z8+MPA9j5d
	wXLzr75xuvg+2vfj5tupQNq84zNMcY5k2yswhgJkwc/GMte/FB8s2pR+/gQHtJGpcMFQfhdgZD+
	qtY2NgUHSRShlIgubvNPxN3o9qtUz1KSoC7IuN1V9lVBbVerqP7l6ZGjDniFQiznguAoiNCLHdz
	sHVjC+ts4tble88GaC2rFt6MR1GF/hJoYFX4iOoIx9LTuBVUMnNpMkTyp2alji0czxupB6ozRUU
	f85k2HUaz791Rb32SgnLFxkVPVEQq5WmMm80/tzbQL1Ii4OowbDMxij55TIpssgP4Ukyo+sqyw6
	J6KUn5RXruwi4Fs0NS3VnAu+CnLieRtFkEbpKvEvsNql6w+dO+8snf7cfgeWIiqtYnJMYEppExQ
	OC86A1Nc6FBmAO1jP3jTds6m8xt17HjZnvB8raRXyHhstImJnKXzssZiruOvvBlSFnmhqAqG+jX
	B1NCFxo1FHN8lXZoIxvGWwbesMLQrvsZHaN6ubDYr4rpct4CAbsBDDtX883f2V41Mfvx0QCMPhP
	W7UOjdUjsAuUk6os4=
X-Received: by 2002:a05:6a21:496:b0:3e1:d997:e1c8 with SMTP id adf61e73a8af0-3e928f72b73mr2095418637.30.1793369148606;
        Fri, 30 Oct 2026 07:05:48 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fd956sm26043b3a.3.2026.10.30.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:05:48 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com,
	syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2 3/4] udf: fix preallocation discarding before an empty allocation extent
Date: Fri, 30 Oct 2026 22:05:36 +0800
Message-ID: <480eccd1264a4cea5226fc36ed108931b2c403fb.1793349907.git.matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793349907.git.matthias.goergens@gmail.com>
References: <cover.1793349907.git.matthias.goergens@gmail.com>
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

udf_discard_prealloc() finds the last extent of a file by peeking at
the next one with udf_next_aext() and stopping when that returns 0.
The peek reads into eloc and elen, and the code then uses them as the
last extent.  But when udf_next_aext() returns 0 they hold no defined
value: if the extent list ends in a continuation descriptor that leads
to an empty allocation extent, they describe that continuation, i.e.
the block of the empty allocation extent, one block long.

The kernel creates such lists itself: when udf_delete_aext() removes
the only descriptor of the last allocation extent in a list, it leaves
that allocation extent empty and the continuation to it in place.

If the last extent is a preallocation, udf_discard_prealloc() deletes
it with udf_delete_aext(), which finds the following allocation extent
empty, so it also removes the continuation and frees that allocation
extent's block.  udf_discard_prealloc() then frees eloc and elen: that
block a second time, instead of the preallocated blocks.  On a space
bitmap the preallocated blocks leak and the free block count drifts.
On an unallocated space table the second free adds a second free
extent for the same block, which is later handed out twice: fsx as run
by generic/091 and generic/263 ends up with two parts of its test file
in one block and reads back bad data.

Peek into separate variables, so that eloc and elen keep the last
extent that udf_next_aext() returned with 1.

Fixes: cfe4c1b25dd6 ("udf: Fix preallocation discarding at indirect extent boundary")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Reproducer, with fsx from fstests and mkudffs from udftools:

  truncate --size=2G udf.img
  mkudffs --blocksize=512 --space=unalloctable udf.img
  mount -t udf -o loop udf.img /mnt
  fsx -N 10000 -l 500000 -r 4096 -t 512 -w 512 -Z -R -W /mnt/junk

On the 2 October for_next base (4ad934e7a85e), fsx stopped with READ
BAD DATA after 9852 operations in five runs out of five; with this
patch alone, all 10000 operations completed in five runs out of
five.  With --space=unallocbitmap fsx completed either way.

 fs/udf/truncate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 0990f94..75151a5 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -124,8 +124,8 @@ void udf_discard_prealloc(struct inode *inode)
 {
 	struct extent_position epos = {};
 	struct extent_position prev_epos = {};
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
+	struct kernel_lb_addr eloc, tmpeloc;
+	uint32_t elen, tmpelen;
 	uint64_t lbcount = 0;
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -141,7 +141,8 @@ void udf_discard_prealloc(struct inode *inode)
 
 	/* Find the last extent in the file */
 	while (1) {
-		ret = udf_next_aext(inode, &epos, &eloc, &elen, &tmpetype, 0);
+		ret = udf_next_aext(inode, &epos, &tmpeloc, &tmpelen,
+				    &tmpetype, 0);
 		if (ret < 0)
 			goto out;
 		if (ret == 0)
-- 
2.56.0

