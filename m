Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268033;
	b=BX/0LVWnMdqiyF/A0F8jPdwSsb+Y6vyt1DfJT8VTC9mzn0CqF50TGQEWJMS7PyBGZ0kq
	 +Xq4OTQ91geOM5O2SiY3L/jHIMH+sgZfFuPsCE4wA7tXz7YqkqFjTd38ee2fVtw3ncCPI
	 jYBOiZugNcbccK2DWyjHdsatUdft/eoEnqJAlbhEwxkG2SQso4JdtjiG5Y85eUH+b4zg6
	 0mnfM29uQKvQrc1/qyD0v8IR5Ta634UsNmy4NtVDya6vHkcJrMPOjYEfeESS4cmBR3Azc
	 zIuUamvsc0iQmuEYrgmuanwMsq2zLnxMwWdpfPEf/fPlHwnbxum906rA+30t26ppDhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MuAgzDOGGZNImhzWO720yvkQx63NEyn8l8tBYbjMb5U=;
	b=Juk89Q5Q6R6BPINMAcnsp73jkncBhQPVYDWWU5e0tosg1flPbmYIRkfOcsM3uGazD11b
	 ndz+IFquqtNJZoxipBT8USgu5VoKeHLTC9bvk1GGrxPa7CYresh1RU+syHQ1JQii2bZhr
	 ggEcW6XCWF7ZeLKfMclKtfrK0/idEkSio3sKa4wdhA34PbQ9oWRvCl6fhq4sLs0V3lvZh
	 twy3KjuQ+oUCUg9U81WBGBa628GPVEd1oFWYBpw7It/xtd1PnTL2Oe8+TsmJeeRH/faJl
	 JegvsY50ZFYaWEoMYgPsmI3UlytRP+8VRF4ZUz2lv6KjW1qKirDgr+4MnbwIdOotLGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JAywMryx;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91F606A331
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD91F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JAywMryx
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e46e449e8so1145676f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268031; x=1793872831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuAgzDOGGZNImhzWO720yvkQx63NEyn8l8tBYbjMb5U=;
        b=JAywMryxHW1yaysWfWfVQAC0k1C8utwWeeeo1Tt788UbG8ftVXpmVToxy8Ui/PbSt4
         pK69YqTnf+OIdIYPJN6q+/TATtv+wPb6XUkI8stly8vXz1CrpvD99gksZmgxsCBYVYqz
         hFdsofdcvZ0c2pmoxr9P1Z9hah+VlU2mF4/rt3v7tpaUMHAMe2MZTZYJkFUr02gPdD7V
         aQ7hZVvx3k6/irktRxITFy4AwZw3x2yeJiIDDaFrgigLPDmwFNhmysyRzGCT/BTLNr5G
         51KTo/tUIZWi2XvnhbhrsfiiTQ4pHKR/2ywEvKJw8dyctfdL520Sdobp3wjnqgTZRaDz
         1m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268031; x=1793872831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuAgzDOGGZNImhzWO720yvkQx63NEyn8l8tBYbjMb5U=;
        b=bDuy8IVfLK8U2MDxqZSkLhGQO0tfcBlZPJfHeZ+mZspf/2XQVUB2R5khB5GTYWNJK6
         BdwI5WuR2kywUL+bZTCPHqw7144EQ1YQ9Jcem6WtCGV60NlZQbsTAQYBaTI3Gbx3FmWw
         jvrpQLA+fHMwi1lc8uP4iaelkbzDDJ2FWvpZGyLTG9l2npObLCdOBBjOY+ut6I+gPzYk
         q9MTVhVyYaF8TrrXdzK7GoeDR+nJZhZpLnSi9wXgL6LGSq2+PEf8/edJlKTBu3jnvH5H
         nYlv1KyyZlYdFMXmd1jUAKzuJs+RSTRmplpQNrMPA9gIu3biBrjhNZoEdfedmMeqvHDl
         z1FQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRrfPonggfMLM4bH5R0mqkwmVnk6sNThzPv5RTRlmVWcyOCwdft18IhLdgN37LqSw4HdghjvQwOS22c3U/@vger.kernel.org
X-Gm-Message-State: AFq9FYJL2w1h/CDWUhiMTBK/ZPIK5BL21+MBcmPOl/EsYu6ToK0dNcVI
	eBrgViLwT5SanEFECCZwA0ZcX6tEBpCxu4H1IdbDqoi5mTK7NWkXaGVH
X-Gm-Gg: AYBFou3esy/2Avbpnb76REOa7DRVXs2eVa8urw3JRtNc415LGUEBs6p9gcZNf/ZyGaZ
	BOhqMJxkXsxJgHUXmQLKGjXyW4wXchYzW35nRla00whi+D3+GZhLkFnDLIehhAJwIhYc1PeuXGq
	4hX4rQkTIgly4CQ4pSmOirLL/Jc7fJlGyLmmQk0YwcLAvgxcyJZuW9eJpS5h2VQUbIZfoH5rdP3
	IblGT30GK2I6gY2mCcbbdvDiuh9zrvmyACRrUPbHVTNUC9oS/HTlmbauWjjM1EcQyg/CPnAOG/M
	gZlUFdRhFPWLQ8NXiAJeKSB9qdGnr5CvVIGbxrfCCIiOSGSDFoJhuCVPXu7FZw4XCX/zUABfIVt
	V7KRfbW5pa1Eo0hebx+dey7sYa35FAdxvY13cbV76jOvrimH/l42FcVl7cvbfbImu50f1+rrWxz
	pCoav2gLg2R3PqUhoumiXRV+XVruuT87LhwsevboXRlVer/xuL8jcHBnt38V5ZzTceg1mmqgxLQ
	7vi16oUeI0crHXUq4dZAHqmitLSHYzJ+W6k+Pr794H3U6I/aeHlTE0OjyANksXZmWbkYsJYUqfG
	8HWwNBFG5wIdHEjTHi14b+rR8wCeCCNUL6xs6DF4Soo=
X-Received: by 2002:a05:6000:29d7:b0:48e:6264:c373 with SMTP id ffacd0b85a97d-48e6264c7f1mr4314548f8f.14.1793268030946;
        Thu, 29 Oct 2026 03:00:30 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm34025569f8f.9.2026.10.29.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:00:29 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 0/3] bpf: Add bpf_path_getattr()
Date: Thu, 29 Oct 2026 11:59:49 +0200
Message-ID: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Userspace code can populate BPF maps using file identities obtained from
statx(). BPF LSM programs need a way to generate those inode and device
numbers to look up for those entries. Reading inode fields directly can
give different values on overlayfs and misses filesystem-specific getattr
behavior.

bpf_real_data_inode() resolves the inode hosting a file's data, whose
identity and metadata can differ from those reported by statx() on 
overlayfs. It does not invoke the filesystem's getattr operation or
provide mount information.

This series adds bpf_path_getattr() for sleepable LSM programs. It takes a
trusted path and calls vfs_getattr_nosec() to avoiding calling back into
security_inode_getattr().

The kfunc returns a 64-byte bpf_file_stat. We avoid using struct kstat
directly as this is an internal structure and this can lead to changing
the user API. Inode and device identity follow the filesystem's getattr
operation, and the device number uses stat(2) encoding. Mount IDs,
mount-root attributes and ownership translation follow statx(), including
mount idmapping and translation into the current task's user namespace.

Selftests compare the result with statx() on tmpfs and on overlayfs before
and after copy-up, and exercise verifier restrictions. The series also
updates the relevant documentation.

Anastasios Papagiannis (3):
  bpf: Add bpf_path_getattr()
  docs/bpf: Document bpf_path_getattr()
  selftests/bpf: Test bpf_path_getattr()

 Documentation/bpf/fs_kfuncs.rst               |  13 ++
 fs/bpf_fs_kfuncs.c                            | 108 +++++++++-
 .../selftests/bpf/prog_tests/path_getattr.c   | 185 ++++++++++++++++++
 .../selftests/bpf/progs/path_getattr.c        |  25 +++
 .../bpf/progs/verifier_path_getattr.c         |  57 ++++++
 5 files changed, 387 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_path_getattr.c


base-commit: d80373a8e70d3193151232c3062abbbe367ff5ad
-- 
2.56.0

