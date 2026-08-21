Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717825EF87
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322161; cv=none; b=AiDDfoSPrNP9jxJctkg+IBvL0QdLR/eJS9qyfH7CkXfdvwUyP1Fw0VNPB8UADm7XvAYchmRyawcxtZqQU9hYWyI+ns0fuBYfhA04GXxZTur1MsKTj3PmAX+c3vzgkwBkmwDMv0Ms2tGeeZVXFko4DL6CKEAs+H5d8K6aewk0GgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322161; c=relaxed/simple;
	bh=5sF0RXwyr0iMr8MjaOHL35Z1gq2gMeitEA/FYdpqM4E=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=eLCUyqZhV4+cojePf7HOfk1wq4zDBHRiyH9g/xa5UvNNdHdv5umIQTXHIP7crSC3EgFQYtVL3DT/OTfjjBIk32v27sxhv8QOQ0sVeWesw/tLVQ2oCrBXN8Fda8BiL6HH4Gwt/KLfJ/Wry+CIrIFLAGT1NfrEsB9xqXIuteKUwss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqd2RxcE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqd2RxcE"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so809351a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787322159; x=1787926959; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYgPMvXM9do2k+pBY2KeyKNzXmSFLJSbdwBoL623krU=;
        b=eqd2RxcE6Q04O0xKq8dqpY4x9lPeZjTQ733sjIEp2d0zYJifla1G+Msh4qtRi7YwKs
         Dya/ChYAo/nWRPlahWo3Al+EfrOJIvkWlEUU93L4AL0XHdvGh/RLgobg61IXn3+yaqaG
         w2A3QBYPpM5iADkmsu3bQVN3719WSFxdS8JaMUJ8A6x4IJN7HasbDS1LtYoyuXdBSTf8
         ub5UmuvG2in/PzwB4zEz6OKfSOQR8zIqGXQd6wvIrf7lnDvUe3nbZwsT9hG62vXS5NJv
         0ROExDDkiruqQr+rG1BuDaTfnGnXlYzUTC3opSyaT+DS4wtYmtJBoF9JrwgUPCnOHYR5
         3uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322159; x=1787926959;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYgPMvXM9do2k+pBY2KeyKNzXmSFLJSbdwBoL623krU=;
        b=fijcjcsjbIUJlnw6pctHp9K2CNdPl9lFMTrAVO3k8uChk/iA+QfbfD08S68Nno/tNH
         r0/LsrNNY4Z4Z625uV/zSxz6GEQgg2+5O1GqO/Wi61lksf21G9kyeGB0t3nKwxTEB41h
         YRuHtig4mgmTq+NwYN3m8SgPUjV/Bxsr8Jqv0e7T9WcTsGebW/FyocGTx7rq06+w/FAp
         8vQJKzwg+pO168pXVNh5DfeJuZKUBBKi+o4YrQCRHONE6ZHGIxsYiD4VIgt6vVMr4Bdn
         vHZ6/kgZnRnmffwzTvWcWA96hsCROSzmXfFk29TI492rxB7MBieVtsb0hJkDh7ulmG2m
         7pZQ==
X-Gm-Message-State: AFuF++n8XTOr9v0bM5XOpU0BLzsnClcYFr0NN2+Mm9vyUnKBkeWZJtGF
	6uk/29WQEyiHQrXSsiwG6kL1SHE9ufaO2AXPRjUe15I51A8FNcLTC8Ng
X-Gm-Gg: AR+sD126aPbprx/mg9TM6CFG0byVkPpoghPUgXg5uSe4t1PLMq+3ywGZI9MZDGHz3aO
	0tVkV+Ug9yNhPqNKWC/21XTOE2aA6S0rDDvbyOnM9/puQMyAVDxFty4X+2c6nN28Y3BGFfA2B21
	O6OJBdDKZv4v5/aDCY2xXEyFklvyvMg31ej1uecXv4lFWLjvsDNghZEl0JqHijBtcYkmVgiJwGx
	F9WFPq6y0YWNo07F1gZXdzbY2QMkbeLAD5v2B4D8HhwY19VDwjDiyX4/eTxuIX6VsDyI/bLS7e/
	xIKIOEDoBi3Ab2AFFNVnBPtEzdu3L313+X+qZOX9EoIWH4WBkk5Z1Nr5COAMNMAOwardOBj5lJq
	X4ExKHAjiYLCukA7gKRJTfqiI+7G5IPtDR7wI86f5/0BpMO5JTPMSz0WvLHJNUwKwGZrJq5ysmL
	LUtg5ylVGuvR2J4oxj1r2u5mud7EZ2X1ckjIuF+Dvyqt4soev4Iu8IYeIbKPCAOU6PtyAHiv0TT
	CiHAgLZC/2BL/GLBrsJyUMTbgmg9+qseKv9gTTonyRqhA==
X-Received: by 2002:a17:90b:3bc7:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395c386e405mr12977823a91.15.1787322158529;
        Fri, 21 Aug 2026 07:22:38 -0700 (PDT)
Received: from localhost (75-172-9-230.tukw.qwest.net. [75.172.9.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10b584sm44718958eec.16.2026.08.21.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:22:37 -0700 (PDT)
Message-ID: <6a885f2d.d76d81af.1755f0.2cd9@mx.google.com>
X-Google-Original-Message-ID: <aohfJYCaq_cb7C6r@DESKTOP-HH660AU.>
Date: Fri, 21 Aug 2026 07:22:29 -0700
From: Dennis Tighe <dennis.tighe@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: reject zero sectors_per_cluster in the boot sector
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

is_boot_sector_ntfs() checks the boot sector's sectors_per_cluster field
with a range test that rejects 0x81..0xf3 but accepts 0. A zero value
then reaches parse_ntfs_boot_sector():

	sectors_per_cluster_bits = ffs(sectors_per_cluster) - 1;
	...
	vol->cluster_size = vol->sector_size << sectors_per_cluster_bits;

ffs(0) is 0, so sectors_per_cluster_bits becomes (unsigned)-1 and the
shift is undefined:

  UBSAN: shift-out-of-bounds in fs/ntfs/super.c:673:39
  shift exponent 4294967295 is too large for 32-bit type 'int'

Reject sectors_per_cluster == 0 alongside the existing range check.

Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
---
is_boot_sector_ntfs() is where the driver decides an image is NTFS, so
rejecting sectors_per_cluster == 0 there stops the bad geometry before
parse_ntfs_boot_sector() computes ffs(0) - 1. Reached by mounting a test
image on my dev machine.

A reproducer is available on request.

 fs/ntfs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index d400fea32..48bea5ce1 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -557,8 +557,9 @@ static bool is_boot_sector_ntfs(const struct super_block *sb,
 	 * Check sectors per cluster value is valid and the cluster size
 	 * is not above the maximum (2MB).
 	 */
-	if (b->bpb.sectors_per_cluster > 0x80 &&
-	    b->bpb.sectors_per_cluster < 0xf4)
+	if (!b->bpb.sectors_per_cluster ||
+	    (b->bpb.sectors_per_cluster > 0x80 &&
+	     b->bpb.sectors_per_cluster < 0xf4))
 		goto not_ntfs;
 
 	/* Check reserved/unused fields are really zero. */
