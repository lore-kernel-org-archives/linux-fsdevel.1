Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D7318B96
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115893; cv=none; b=aPRzJjOts8XGDXfmlmiMEB75FCf6GQqSIHUVqwyQelrQKTQ5E5T4woLF39vChr9k/bq4y3nCunuSG/dngr66cbQR+qQ0Ib0os6zmwQocyLUwBN121Af/jfw+pplGLAlLKS9NuD31Dh9yPKHEk+sdvv/aEGFPTEkyE5vjj4VpfzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115893; c=relaxed/simple;
	bh=zGGPaqWnVG9ntNpoQF5j/qvlu+agJgYy2ILG3DESs1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jM/9Dl6j4h4ezZuBD3P6QvV1UiW/5p/067uIUlAbNRtxLeNugxcwGYWTfenftceh34dx+qHqhkWJOiiscxv4Rgl+3o4uU3Kai3kzkV9KIsA+oVbvIP35MQnfF0O+rz4PV/s+HKcGjdKItuu3+HoQeWUVyq50/PqBnH95kP42oQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=e9dxxzRj; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="e9dxxzRj"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfc085395fso157812085a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774115890; x=1774720690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mlBDNS7j8/emmWuIK2UQ5HjoS/QYu92EKlQy9xzW8WE=;
        b=e9dxxzRj8OFWZit5aejDYSe1EDeY4RB+P5fQmsIjbZL3xZMu4S2DijhmtjvhxihPda
         uuFOh5tBaXMjUxAIjle+H4TlnudP5iSCR1XKstdOa0jOwmRsHCD8/o+s8d13FRHSnUiX
         wzJvwYaUBPjelsy1M/Eqeo6kYP/py6SoD8oljdXCqdsdKZwwq76XQ4NfSeaXQaf55wlW
         cIAik7UNn+oE74N5+WLxysXs/1JrPPdykEPeN2LCEaXAeitv/OgD1ou3XsleRKaMcu7C
         7JNcdEaVH+m0dEuTqAeTiT9HY+SNevHeAswSrhV1vmaomS4ZfvO2py9c96TxqmLcHf1B
         wDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774115890; x=1774720690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlBDNS7j8/emmWuIK2UQ5HjoS/QYu92EKlQy9xzW8WE=;
        b=KJJf9gF7E+mNx70L2OXMY3fS7bN/XpRL9g3wmchqG5I54SasmuEfKnR8WLb1gKwmUK
         /S/Wq0c6yr0Jwg4Kpq44ZFM6OroNcdl0CtWJ/g3jY6VNjpP8EQfTCxg1H6KDZH2K3LeF
         EQgM2cwboyI1A+yAKRVahwQOnG0isid+lKsqRmthRiyKIkWRrn897Pq6mHiqozqrCuR+
         cKP6gWQWlww9zqrZTKj2BFwsiFwzGoXCvXVOzcmpN0Coe4+MpJD0/7RllaYbd2nNuh29
         M3bY1AxYJU063xqm/YRb9WkYxDxPh5cebQZOJLnrTwfmNbQqCyi05RbEM8wD9C8O6Ln7
         UG/A==
X-Forwarded-Encrypted: i=1; AJvYcCXxRdMrbM7Uw2OibFsyo8ZQDn7OnK5SoXadhtz+4sib5CiCs4TJ4dpOMNRi9qzu1X7i5vcvaA2NAtcaS0zW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OjmDe1XxwAcrVeJwJZ3IYLKa88wsikCoEw8D35I92tGs4Y8N
	fcSqK8me3J2pTZyM2O7VXJJsGKvbY2S6QDsVCH7OhCrRAzUOzKFXUUtwcGOFkQ+4eKE=
X-Gm-Gg: ATEYQzyPGs6t6aNndwFh1tRsnyYBbIeAzbxtZPtx8IYntyaa2ntvqlXUCpZmtMun/tI
	YwC9HbufRQcOahVa89ynvfSzunALUhP3Swqjo/wunOgj5qNDEWVv3oKWg7U1u32U7D8MX/WMRxJ
	unNYG/Fl3xwT89Ab0CNpE1d3U2KhZ4dYNVXsUCPyHvGdxvfYJGAvUjzA9+VO9ubTCHCOQI69M8D
	7ajby+Oeb5+QtXa8X4hXgP601EVUjkM3xygPYrduLh09fJXd1UoDNrUfUCvhZZObEoo5WPOuWgd
	oS7/J/AYDaEi1mp7jiQ+TTbWk1u/IEwMnkVxMl3+OpWqjek+D+koyx0dM8+QvSt+Z6kfjSEuTeY
	sO+oSozPQX6Hnqy1KtZanUFsTkfpp1MMnJcSO6s//ACSkzfRM91RCbC6ik9wmWaz0+XlffyA8YZ
	dQyBONRXfH1ZhX3IF+Hqf2szKoyUcBAOZ6cUYajMxN00/93PEL2Y9cepsQYZNJaEv459DZf14Im
	7aD
X-Received: by 2002:a05:620a:2802:b0:8cd:87aa:e3e1 with SMTP id af79cd13be357-8cfc7ec2244mr1057915785a.29.1774115890136;
        Sat, 21 Mar 2026 10:58:10 -0700 (PDT)
Received: from plex.localdomain ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9089ca9sm426515985a.24.2026.03.21.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 10:58:09 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: brauner@kernel.org,
	linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	jack@suse.cz,
	shuah@kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	pratyush@kernel.org,
	skhawaja@google.com
Subject: [PATCH 0/2] liveupdate: prevent double management of files
Date: Sat, 21 Mar 2026 17:58:06 +0000
Message-ID: <20260321175808.57942-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, LUO does not prevent the same file from being
preserved or managed by multiple active sessions simultaneously.
This can lead to conflicts and inconsistent state.

This series introduces a mechanism to prevent double management by:
1. Adding an I_LUO_MANAGED flag to the inode's i_state.
2. Updating the LUO core to set/check this flag during preservation
   and restoration.
3. Adding a selftest to verify that double preservation is correctly
   prevented with -EBUSY.

Background:
Because LUO preserves files of absolutely different types: memfd, and
upcoming vfiofd [1], iommufd [2], guestmefd (and possible kvmfd/cpufd).
There is no common private data or guarantee on how to prevent that the
same file is not preserved twice beside using inode or some slower and
expensive method like hashtables.

[1] https://lore.kernel.org/all/20260129212510.967611-1-dmatlack@google.com
[2] https://lore.kernel.org/all/20260203220948.2176157-1-skhawaja@google.com

v1:
- Rename I_LUO_PRESERVED to I_LUO_MANAGED (Pratyush Yadav)
- Set flag in luo_retrieve_file() and clear in luo_file_finish() (Pratyush Yadav)
- Added trailing comma to enum (Jan Kara)
- Added selftests.
RFC:
https://lore.kernel.org/all/20260317023834.487682-1-pasha.tatashin@soleen.com

Pasha Tatashin (2):
  liveupdate: prevent double management of files
  selftests: liveupdate: add test for double preservation

 include/linux/fs.h                            |  5 ++-
 kernel/liveupdate/luo_file.c                  | 27 ++++++++++--
 .../testing/selftests/liveupdate/liveupdate.c | 41 +++++++++++++++++++
 3 files changed, 69 insertions(+), 4 deletions(-)

-- 
2.43.0
