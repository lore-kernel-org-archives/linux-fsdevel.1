Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493426;
	b=Uq5R+rS4aCfvhsn90dXiFFlwU1zP57BoMVT8P4wfzTslhuj7eUuKFtaoI1ao9+FBTJ5d
	 wsMkGb62ihK5vI7fd0xyxj3kAK9HJEMgkT94npJEH6ufiwmbSKXUYjRZMhnQ9p9mx0sQV
	 yk+O0k3cJx9LLiTfUnRbg7e7AcgCvMEFSUsF1+NCaUea8gVL9uoHC5UILVAOgAtl6PUKB
	 3xagk3JFVzrj0bNsT9pgGiJtZOLn8uGcFZbtnSKdJfZunvm3MceNmzHQEuqui2AxZPfLw
	 DJFv7i/fwQgwkUKDIqvr50g5hU+yv3ArwwCHGv3Qlnq3tu1EjGx9hyejVy8JKI9BATw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9Kv/ULeJ6pUo5Q5w5vFxVRD84tjRkymD9RFQwaVpcn4=;
	b=ZSnBRAulrxCk2KFXrMJQIys9oidmcEzmdOqzDDNhyBNEsM2eMPC6iMLTNhQm6vbEEsmY
	 /9kbcRBhmnEQHf2b4i5mxQu0fjq2Uujna9ezgvkpxOCUy70XIgfrn6e+iJVjeeGCf5Sxb
	 /zoqBbBG/RxpU+2ZQMOLULnfeFnb9HBuyo1v9vAkS0AWUYnwTcVscmY3eb7Yoaadqq9z/
	 Fe0bUv9eRV5KS9mMnsdTLptmX221x6tF1xZaRbYrm3bHjCoHfQvY6g92lNObsQfLItx5F
	 NvKgfyC7DMCdMbKknIxlAfbBT+SsGrfiFtT4j9qVJcdfH0uNAPJi2Lp/3DkSjXk/ARQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=WghxI3Up;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2B60A2624
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 10:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E2B60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=WghxI3Up
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1759115a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792493425; x=1793098225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Kv/ULeJ6pUo5Q5w5vFxVRD84tjRkymD9RFQwaVpcn4=;
        b=WghxI3Up3cKf6RyLG617g6gp1fbtM68Tu0QayXyEvueWNs2uwXsB4pl+epAB0GzAHN
         lmgnE7YrMpwTUjbnDobBNSl6KXoekV1BoqFvYEesxFbS242lLJXNceTMlY8qARByCF/r
         b/+GtY+R7jR6F6lGmWoDWR1GR51bFvn7agdI/lDTvzCCvTs8QSVbkT0lJJLRFbeYxd1K
         0Byhx/WEUFCgoUA2/ybpWhk3c+BOiloYorMYFm+ZW7dFKwsxkgeC/tEDNocIbF4kC1Fz
         GG8BdTPf8Bggy3gvBxenoMElQ/OKp9g++QhNpGJud7t+aPKpkwvMW6YfiPeZzzqpJD3D
         Ip7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493425; x=1793098225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Kv/ULeJ6pUo5Q5w5vFxVRD84tjRkymD9RFQwaVpcn4=;
        b=QPPl3Hrm8koCG7FKLxCZXXegAe70VdKPrvF/wk5xRnOXoPccSGh1RlL3dJctfY9n5y
         BPYn+KoZgPHBn3DGRoQ7s0AqSHkMUE4PsnohtTNRcWiJBYgHDA1fpbxC37KL3cH7IAhl
         v+D1r0usv6VLLLa/g84JOTdDk11bouQZPy3CCWZ7vZH+CnGmrEAqPo/d2h8qCoLm+A6+
         IOooBjQfd16lFNYZYbf5IqScfqBRd4YOBQBLW9oBHiseGQGRfx8Mkrhmar2bWTaXClXD
         KV8Vu371sX2WLtIfhQDsSq2Lz81zKbJFA+Jund6fp+DaQDGnWb643PBbSnWqOelAMNZd
         4WNw==
X-Forwarded-Encrypted: i=1; AKwUvBxTXHBwt42QklUs4IML6uZ5oSjAJWmIa1x+AecjhcWNL575BOcjg8dPpuclD1KgM8PXdDNpbYBXw/rNsMj9@vger.kernel.org
X-Gm-Message-State: AFq9FYK/0i/OPO5D5eLKTOk4m89fS1oNvJXYKhsJF4l9C6Arc5cEuFfl
	hPYQaFiCITa74oBxim6k+vMmE3mJyR0V+MiIJVVu+ZkBTHE1YAV73cFUqmIpE8HKhJW5
X-Gm-Gg: AYBFou0naeoe9uaPQnWldESq/QsQQP/X+niGcF+Z4f1qA9iP7C1HyogFWRNSg+ZttAx
	VycdgyBEY8moCKdYhkVROftpD4ZJQ2Y9tMG7Vbb/oHQ3eO7L4DXlTGHojG0xv7F4lIe59caEzXg
	w8rPaISLdA9ZkfZ6LoDV1GXyfK+ORSZsLI6FprX9EikiAUzyAiFCQHvAsUhSfo6eZxRdc5+r0ji
	LTDenW7qx3FdwFSmG/UMkx0iuwHJdXRezTPJPrMovhYJ2NB4wKtTEEbKfEaQzKZfvu+yt0C5mwc
	DhIw/47++AbuMYZOwEax2CkX9lgsiioBDM2t25cQJU4S0yr7mzrcNxXdVNibU1SGx3Gm7upurOb
	7RHnx5K8QPcYWH3H2AxXcUK6Im/EdXLLmhbMkip6lKWHmwwqBgZJuEtSr77KbkYyVYk4ZEDLHHT
	V45+/oZccrkypEctBCaUgce4KUa8QlTLWSTZzdpv101XDm34vAYXZi8CNWVs0X6H1ECrqhomTmM
	YfD+l18ae6o9+tz2BtHmQWPN/eoeqSHk9ywk/rCc+sFgNtP8QrHl5KHS0MBCTVtaK4TIV7T5Yjj
	NeT1WmlMMNVMS9ZRz39Lwzl0s4A=
X-Received: by 2002:a17:90b:2cce:b0:3ac:b3c7:de14 with SMTP id 98e67ed59e1d1-3acef5c8cb3mr8447674a91.61.1792493424631;
        Tue, 20 Oct 2026 03:50:24 -0700 (PDT)
Received: from workstation.. (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f36a5asm3487902a91.9.2026.10.20.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:50:24 -0700 (PDT)
From: Matt Bobrowski <matt@bobrowski.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Matt Bobrowski <matt@bobrowski.net>
Subject: [PATCH bpf-next 0/2] bpf: fix crash in bpf_path_d_path() for exiting tasks
Date: Tue, 20 Oct 2026 21:50:12 +1100
Message-ID: <20261020105014.97985-1-matt@bobrowski.net>
X-Mailer: git-send-email 2.47.3
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

bpf_path_d_path() can run on a file released from exit_task_work(),
after exit_fs() has cleared the task's fs, as a BPF LSM program attached
to file_release does whenever a task exits holding the last reference to
an open file. d_path() then dereferences the NULL fs.

Patch 1 returns -EINVAL from bpf_path_d_path() when current->fs is NULL.
Patch 2 adds a selftest that crashes the kernel without it.

Matt Bobrowski (2):
  bpf: fix crash in bpf_path_d_path() for exiting tasks
  selftests/bpf: test bpf_path_d_path() on a file released at task exit

 fs/bpf_fs_kfuncs.c                            |  8 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 51 +++++++++++++++++++
 .../selftests/bpf/progs/test_path_d_path.c    | 35 +++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_path_d_path.c


base-commit: 0007654a7bf13ef2a19afd398bbc6507087f19fd
-- 
2.47.3

