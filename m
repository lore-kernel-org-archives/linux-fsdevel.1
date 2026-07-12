Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85770344DA8
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783829334; cv=none; b=CrFWQZ5pwS4EZUMul+Ce86enZJNGAwmRT/MjbZqn6UjYTBBY9RwlR5/hDiQCAnQiAhXCbAYCTwkZ3Scrzd/Rq6jCA8OGagJkA+aCsEJ198ld8mHs2DHox1EOOLcnQ96EzoZf50j/AHkO5IqkJ1B4/XLo4FMTClu4utATl+LvzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783829334; c=relaxed/simple;
	bh=1q6mbB/bkD8j4HZw6McdfhEuY8vqwQWBAE158sj4Y8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZbJex8loTZJnxmxDMwUgIUhb8hdnBCPW/x5oJBZnVjNy8HPKzZHE92muycnWE7xzjGkSrkeeOeHY3NpuJdmC9Kkg9P0VH9NV8GIpMcrHcQxTs69SurZ2r4SkEXiSzMHZRmfcbUlEEZamM5COhxcjHTGiHdv0HqRBpuiKcuHufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbokcfpl; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbokcfpl"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1717840a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783829332; x=1784434132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1vSs3PpxD7fzzGCyEVeEQofuGfZwATqltGOSkAKOV+Y=;
        b=cbokcfpllFKwZICTa8uyEtG3gK/7FawCR3BdoMCN2eYnV/UaEACwX8YYUUTY937kqu
         XrhvbfA812Px1NShMdXdMLykuPbxRC5P+2PoPv3ARp/vRKOFfCsUPO71qaLla4K85qfO
         ztngsdEEwdwI/6rv+0V2rsNJiSerwBjniugxklJfOUOAXlFU04Zch8ec5bzDlUImavL3
         Id7FFDrNo72KepusQwMZi7n2BOfd/7MWmiPrCIH09//1ijwcKdTqEj093c8nw4Rw8EKl
         zjzAQu36pZUYE9gZQ+3xDntkT/jY0pnlf+I4CD2rhkkarpitFXpDnOZcUQt1p+r15IRj
         wyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783829332; x=1784434132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vSs3PpxD7fzzGCyEVeEQofuGfZwATqltGOSkAKOV+Y=;
        b=Gpq01pjDVaZvC7kt20C6S6zm5fRqXoWUYRCsLboNHlR7773Pu+RJVPx3k5F328HlQ0
         2WVx4avraiyPQ6xAgkv0DHKJysXF08sB1gc26Wo0BWbLCw+n4stAZSssLTX0JZuWXc9j
         UJt3XS+SfE3hlsE+dLIZrepU76K7SeEX0gF/7jNzUQk0ch3MWc3YUXHVFV7JpTtpNXvc
         p2GC29arH+5NIMvcO7rZOoUaeSy8OK5ESGh8xlr8TfmTkSopXMN4zw182BPul8t+P7bh
         svUfhtwYwA1ymQrFOXFtgMto7YWPQ2HcpRUXGasP0tB6/AsWOKUc0FdiiyAKd6kra1OF
         4OkA==
X-Forwarded-Encrypted: i=1; AHgh+Rrh0odi8OwnA2KlqDW/Li7EodFutBzWjJmGho/V8tKEewKBGQPt9TUnsPMaJedkdFTHAGKxgJxxh/b0qaKC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07kQJEGNrPD2wn61Kul4TzZNYHXoEBbWrdpK9q+4Ch72AZqHO
	dK9TZWy975qlH2/nm6gcy/KAXSoDR8ZzcSEOz36OOtZoubP3dOwsp1S/
X-Gm-Gg: AfdE7clCaa1rE/q2seqqrqmBr4KNShE4RE5oD/SYqyk4F1z5QkjV2D4hlJMgw9PyR48
	irFEuRez3A/znQ5i64bB6ujLiAOcQaR7L4QI/77J/yFp8aByJj6O+ag2s7a50eTFzg8h7mk7fhI
	lDioP+d1Qk1AvH0wvZfnC8Xg/cgSMetdWR/Qqopajxw8hjbqP/Sf6zZecwckS8lMtotNjjFGjRg
	MW+ICMLO/pOUOVKhYbQLPgGI9cKnFlZQjoOqq2HDh14ySn3sl/OZ8W96N8/6v+b6+H+C7/LSiif
	GmtJFEAWpDiGHOybF7Hm82dB3LuxTFiPQ659iPMzrPcT3ImAEa60y4K1pXvB+pT2NTPpeQUDSx1
	ULRBdSZtgTijXZwo9dzD/315UQvht3PRZl09MtKqemFgIlarPIVMibs1ZWN9grExl/Xoh365QiV
	h4pbovVqhw+mg34bVPQxZmH63rt9s=
X-Received: by 2002:a17:90a:e7c4:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-38deaec5594mr631416a91.11.1783829331759;
        Sat, 11 Jul 2026 21:08:51 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm56808928eec.10.2026.07.11.21.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:08:51 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Sat, 11 Jul 2026 21:08:14 -0700
Subject: [PATCH v2 1/5] exec: stash a bpf-selected interpreter in struct
 linux_binprm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-binfmt-misc-bpf-v2-v2-1-d6591ceaf207@gmail.com>
References: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
In-Reply-To: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
To: Christian Brauner <brauner@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Jann Horn <jannh@google.com>, 
 John Ericson <mail@johnericson.me>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

The upcoming bpf-backed binfmt_misc handlers select the interpreter for
a binary programmatically at exec time. The selection runs before
load_misc_binary() has copied the binary path from bprm->interp into
the argument vector, so the selecting program cannot go through
bprm_change_interp() directly without clobbering argv[1].

Stage the selected path in the bprm instead. The bprm is exclusively
owned by the task doing the exec so no synchronization is needed. The
consumer frees and clears the field once the exec attempt that set it
is finished; free_bprm() covers all error paths.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 1 +
 include/linux/binfmts.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index b92fe7db1..7c9e28f54 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1418,6 +1418,7 @@ static void free_bprm(struct linux_binprm *bprm)
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
+	kfree(bprm->bpf_interp);
 	kfree(bprm->fdpath);
 	kfree(bprm);
 }
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 7e7333b7b..1dbec6905 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -65,6 +65,7 @@ struct linux_binprm {
 				   of the time same as filename, but could be
 				   different for binfmt_{misc,script} */
 	const char *fdpath;	/* generated filename for execveat */
+	const char *bpf_interp;	/* interpreter selected by a bpf handler */
 	unsigned interp_flags;
 	int execfd;		/* File descriptor of the executable */
 	unsigned long exec;

-- 
2.51.2

