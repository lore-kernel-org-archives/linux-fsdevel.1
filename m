Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75318355F34
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712364; cv=none; b=IUj/FU3bQWmZizIXBtk3VXd7AJSbpymcNybyibrtUeKZ9+9zami9A4C55oqHm3KhbrkT+eUbKFWArGN25DpVXtg5uW2Rh7j/T+933q4npXu3cHw/NLUOpkeVh6SPU+KTuaEImtZyShXAXbGK45++qo7Srp18KzTPD5AVwMcZxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712364; c=relaxed/simple;
	bh=HZYHztId16pgGQ1AA2UfRM6DJRt8s7EcWewCjcgDwxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkzPafFZDQaUwD9OYmG/uBliYqVz0e+6KK34hfpY5b1jQkS7GsMF2jDAyAFPisuj2nms5HLdvCzgrKMIXf5Jb+8m3BI68hLXTIfMBB/sebe7tGVdF4RpUfihQJxuaYiaLhGPaAy5UizN1EZy1P1ikRvuRBTBTOUsxg8ulPV8PEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezlCOcJO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezlCOcJO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so1925472a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712361; x=1775317161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqq43BIgVMA1uE3zJr5f2QtdxqeDEFGIZU0biEFlpEg=;
        b=ezlCOcJO3ukt+ohAjgFlmQZFt37Ru+IjAfMwLrSQJk6j1ARtme3G07GFd1I2FcFYtV
         N9zKucl2GCWdjWpBTqLNZCtnlfnuabV6CV/zcqBDbR29pnMvOTvROacsuSrdRXggBbmC
         QSRDXC+Z/A8MhuxGqZLfk52Nb7P1JHviubV0JbFaeMQuiWOsbKL2cCq/fCBSAPEOpYVl
         d2cMD0Ot1J0ixBnmQIQqNVdgzbSXLa/wB3aXJKuDf3AHGiBAN0Mr/jx58xO/51dLVo7Y
         c4PfRF5IP6BkMw/1Ho6Reubvgyh9aqD9cQQXvpEDTpriv6RHaFXMM5lcepBV5kTAMIHr
         xZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712361; x=1775317161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wqq43BIgVMA1uE3zJr5f2QtdxqeDEFGIZU0biEFlpEg=;
        b=rEAOD3pA59UEHndkfGBXKDZvDUqD8rj9zn2mxfy5iSUFf35G8EmQa6HlPytMQSAnXU
         Z5gKM5gjuDvSUUM3uWFf0vUxq8tFXP2nyESMicQl4Eol1xrRlDLcNqqpSKziY9vI/y5g
         C1bn3G0efLDeYqFDPfPgxoTxjSq5v4hugN/D9zimbmaPowfsBOwCaP4Mye29izWGHRit
         qO1j8lzzw64XHamCx9dW+ZVhAKm/kp02nKvG0tHnOrH5Hw0akI66/xa+oSai5+GMTBAZ
         Cg6N2oexjtN1unDrf/LDIOupmpzS+YDTjV6aop7r+b0OtfimtI7tkPabZvzHT6MDTnPA
         Odww==
X-Forwarded-Encrypted: i=1; AJvYcCW/b5IjhGnuePj+u3UrVJBf664/KVSpm2RVXYkKYfnWcbLks55Ww06fQ/bNLQprAYjtlfEo+RAy4Tdr1fMt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8bS84pbsmm9BMnhrJp73VEnDsoocOt8vM3UI6SI/msD9bWgQm
	/iLSkxobJ4d2CXCMfJpAUqfZkXjsDs2FIgcgqnS120SIM83WEGqklK+cF+ivZw==
X-Gm-Gg: ATEYQzwDi80rUlc0J7UXRJJW5oonxFn57dD8SX/FMNfAc6xtU9QXkKiJGH2hKzGs3e7
	zp/3nbZGNcEy60ZfxAG7sJCcBADEqdbNZiu+VB29viOBiw5WCUO5UxEe2lbMRzLwP+VkZCAKhHO
	+OHNOAl77zWC6JkrBvxFPAc6PSb+ExjJsixdr+Dct0ZMtB6CbUTU/3HuenRESKjMDkPO8fr+JYP
	bz0+tEc6eGpK4KCpGkpEp1CXXOj7SYVulElr20UYDF0WHMl6IOlGFnm0PxcHi3EsOXu2BPelkA0
	XJoScdZho56BdG5X6UoyhAM4CqsSWRgEjIoxryn9k9LieiaI0kp5QjsMO/9+oOwt9jTp2rVNRLS
	kDgnvavTqgu7eoLzY9ttEwenxzwtt02Oytyi0OVTb8zL1Fx2LSDP1YzHLcGL1YoU3FEs8kR43ii
	R5bplJRKrC4kt3p1AbsOimkwR1ax4AZpNapKvY/pRd7F2VpHS3x1AsmG+3skSdcHr/fD+IlGY3e
	GK3StztU7DB
X-Received: by 2002:a05:6000:2c10:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43b9e9f9d91mr11294450f8f.23.1774711926113;
        Sat, 28 Mar 2026 08:32:06 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm6725310f8f.24.2026.03.28.08.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:32:05 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 3/5] fs: enforce locking in icount_read(), add some commentary
Date: Sat, 28 Mar 2026 16:31:44 +0100
Message-ID: <20260328153146.3368470-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328153146.3368470-1-mjguzik@gmail.com>
References: <20260328153146.3368470-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0cf27085a579..07363fce4406 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2225,13 +2225,21 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+/*
+ * returns the refcount on the inode. it can change arbitrarily.
+ */
 static inline int icount_read_once(const struct inode *inode)
 {
 	return atomic_read(&inode->i_count);
 }
 
+/*
+ * returns the refcount on the inode. The lock guarantees no new references
+ * are added, but references can be dropped as long as the result is > 0.
+ */
 static inline int icount_read(const struct inode *inode)
 {
+	lockdep_assert_held(&inode->i_lock);
 	return atomic_read(&inode->i_count);
 }
 
-- 
2.48.1

