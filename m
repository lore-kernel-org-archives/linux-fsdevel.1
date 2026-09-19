Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A43955FA
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856261; cv=none; b=Cy8mZtYofRJoLCZKVZaFGllnQKuwK5r+PLJiWutlW8sarYunAspFarHiF+/KxWMGaWvgvQFwCXloLbAZs9fTq7XsiagYlG805d9wDBq+0uU5CFdMvx7dbLrCRfGePzUEvfuV887wEaZBfkTg9liaq7BD5JMCpHcKP0rLq4omhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856261; c=relaxed/simple;
	bh=t642PwJWjojmaMHJHUOBwNZC2gg85Z+KOK1iAR1puII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DO5ptSgZnBUVmFYzTUqyYCX3IRQI2Jbnq0B9v2XQM4QoDjiKU4tclcGBtIgN/0/3D5h2ziw63sfcyDwWIK9DMpCDW6pxUl1V4K04SN5MDFAckKMX9xGO14daLxF8eZN8HRYbQV6/5m1YR7HpcFpB9HKaVYySFT8Qp8qRlZXucmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEgOvEhU; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEgOvEhU"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1277390a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856253; x=1790461053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CoTvvBhiuJUSempXXTk5sVn8pgEN3yxhBykVA3MzlQM=;
        b=YEgOvEhUmLfVUQT4Dt/8Qdj+pzc+hcsqSddqBs62QC8ixcBQJxGCx07AiCzZCRkkO+
         lTNCvTOK5YLzh4AMubW+7yoEc5GSymrQ7ZpHutjMu+doz8pm9jU+OTFFgsHXBvJlyaen
         DOub9HZ7v8GhE5Y8qsAikSKp/YAEkN2iWBkAJOvgr6etIWc1ak90Wly0JuL1HU+dqtIF
         cIH0qAZuGPTeShmrJZvuEtLvvcL5ox6/wxUK1KAGzIwz7iSJyshfgh6O3+q59lDiu54O
         fKNcZIMFngX3NaEq6X/LY2AUZHiCBrflga1tP3EHifXZheP+aJ/NfkWa1tBZVVxv8df/
         eSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856253; x=1790461053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CoTvvBhiuJUSempXXTk5sVn8pgEN3yxhBykVA3MzlQM=;
        b=Y92BMmZZTBVlKifuL/4NYMDHBJ4sYjl/THilWdH8vwCFfTzcnTT3Q8ou9P+pN0sV0p
         Hm4itX5XqUdkZ7aluuxwDSVHjJSng3jRGygGbIPCbojUlRhcVOUb7On4k0Nf/2nzcG00
         SpxIFWD9+/EFd+sxzYO6HT0yblzWC7iZTSey2Fr5MHeJTLUxFFwdojzPwUQfyTsr+1CI
         waJmMAcjYrV3z0RKRj+iPk2A/uuLJFyQoCO97243Z+nCzQGV0P+okh5HP+/s6lQZaJ7r
         JjfLJQ8pJBFFHyHljNviN4/XnWpnF+21QbSOrtcQXnvISU4SpIcJ2g+ynb2tmUQqWawo
         K4YA==
X-Gm-Message-State: AFuF++mSGY45tT5z6doJqZLX3+IXqjCdSTUKXk9YwUWo0yiUUbcIxV+7
	ba4naNWTYXqu1xZqzTXRpa8DUaOigDn+nPzISZgbBVmyV7a5I5kPiCvA
X-Gm-Gg: AYBFou31mNDYvu828qU8e0q1HePvL1lRNFnCzuxM0JF+9ALES7msS9EQTdDCCDIpNNo
	G0ybfhMMB4/0hnYz9kJb52Jl7bRl1eIjbmmciY7iyzpvKsghEyUDYV6huDqKI3wUisKiXrH3to1
	yW/vMO3wAqk/h0YhEe6WZLDRub3A36w4G5/FL+evexmjd8VvWea4+3Wkap6Hs0X0JaQMwyv1NbF
	oTAZFwUphCkysLYpPc/DTTyjSs0oyUXYCJ13647iZmjT5KztRDOyNlw39uYxjnRRgebBrIBiO9z
	NhA2F7ZpTJ64dzGK1L5fG4lr3k28tIyedmX8HGcEgriCNzUvfTs0YIvm/cJ1BQrs+fYO9juNceC
	JbZRz+cjDqeYJV2JZyrxizJMUGvfye9eh6r+Lh9pcFQg8y/2sO8rCax6IPw99XpJB0EczDGjA6H
	BREt/v+AARnZ34CiDPiCQg4jjwa791i2P29yrNnkocaAKRDWf3Cn2SBPIFwdIW7t91PJ617lC5b
	0UU1Xr2Xfc5kit60AkZI/3hBcyIKY9IYN6h3iH7Y27DdjbYZh1m+BApCMSCGadvGqVUQ0zZwNYm
	qTNwsJPPKQ==
X-Received: by 2002:a17:90a:da8c:b0:39e:1310:cb36 with SMTP id 98e67ed59e1d1-39e54d10409mr10479870a91.20.1789856253000;
        Sat, 19 Sep 2026 15:17:33 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb372b7sm6340464a91.15.2026.09.19.15.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:17:32 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/namespace: reject bufsize < sizeof(struct statmount) in prepare_kstatmount()
Date: Sat, 19 Sep 2026 22:17:32 +0000
Message-ID: <20260919221732.3707664-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In prepare_kstatmount(), kstatmount.buf_size is initialized from the
caller's bufsize argument without rejecting buffers smaller than
sizeof(struct statmount), allowing string offset calculations relative
to sizeof(struct statmount) to underflow or write past the user buffer.
Reject bufsize < sizeof(struct statmount) in prepare_kstatmount().

Fixes: 68385d77c05b ("statmount: simplify string option retrieval")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index ae5dc64f8b45..7f7905286fa6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5882,7 +5882,7 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 	ks->bufsize = bufsize;
 
 	if (ks->mask & STATMOUNT_STRING_REQ) {
-		if (bufsize == sizeof(ks->sm))
+		if (bufsize <= sizeof(ks->sm))
 			return -EOVERFLOW;
 
 		ks->seq.buf = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);
