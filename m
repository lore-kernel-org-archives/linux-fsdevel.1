Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168122;
	b=PLPdOIIeFnE1M21a1kc+k3Jhj47XbXNcBw+isYwfRzzkALrrSTwCcNm8fR09/qfgqTiv
	 k7Hy56ZhWyHOwpr7ur6Lq2O5tSSMjZZmMAzjcD8A6VP4fZQIGbppfc70uXPL4DmDKfPtL
	 a24zs911SVpiQNMqwdgR6V6GO3JD9/BhHO6sYOYT+1Z3WOHIpauCvvMHJPTrnaVub3mMZ
	 wCpkkb/ITEn+1yHGE0zaonXWCXDFPditXtcQUt/E1w1F1/39EjPktlMR/PXB2XNtCOqWh
	 OxycRi1A9VW2eCtfSinEGZuD7CdGkQTNjeDJHU/0n9a4CiMFReVbFYGiUeLdbmGfflQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LrQEkt8HXk1ed1syfHwtkDqVdWgo9sprdy8k9nccOT4=;
	b=I3eXj149/0ahtPr+N9oex7oIuuRtXt3PIH8yNF3hSGqu04NLZIdvu6+H7ZvdcMDPLhTv
	 Zfpt/oZQqIFJYgk5MxJgbABGte2TyH+MUOvu2d4kvVvwiwcgOuSMvldp15G7BldK8eJjf
	 RC7tysPI/zG4wZ2s2SINU05In39vDgKcfqtCNvc7039v+OtvENOxfJpNmPhBils78HCVG
	 EuhwZn0GxJ2SaKPkSn0B6TK0Qeky0bFD6zVnpXFQyDivdchr6scIgk7A2rN0QbsK2asqg
	 38ATZB+wKUz6D+6zIrzJyhKQx3jUTMHMq2zoXohZLgoJB61/7TVJ3hvQXXXW4l0mSsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxSXBoWw;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC62606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 09:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC62606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxSXBoWw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so6766705e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168120; x=1795772920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrQEkt8HXk1ed1syfHwtkDqVdWgo9sprdy8k9nccOT4=;
        b=QxSXBoWwFNgSQtDk7FgcCwW7Iu7sNYfShCcuyAaffjRYinW70R31yZM+yPr6wrXjjt
         Bf4ypvCIuYxbTCzsUWJFeRf8AEu0GkpIeBMjk838RaohymTeJ++xhTBHw1EGTGpu9XMz
         KXgyco+DZVAyVTUlpBQv65z13lX7OxIRmbehC1C7HySWbZUnk+JvFvoOo+RW/RhbZuXT
         LJEU4DHn35FBs0y7+1rXo6NntmSmoLsAwh/KcXyBPBt6Rm8I14A6JYeYi/6dOtC8/ig/
         /z56iB3LRlXa9yM8UWdWuNHaZ+ijxWjp2HKs7NWwO7xKLQzFisYDnwLFhf9tfVPaeW4W
         ICMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168120; x=1795772920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrQEkt8HXk1ed1syfHwtkDqVdWgo9sprdy8k9nccOT4=;
        b=tRdV/RGsvsaOM0pq+dlraqqkhsJOa8hb+khnXF5BuZSndO+taFL2TVu7KZLGl2iP4D
         ggxFXPIpbrXfPz+/vsVs49NeHskhv8pWxninS/7Rl1To5P8m18QtwOgOdxSKWbwfagGI
         zUOMgWM8+jVUXYSgmpPinyW4UOQPhwpEOBKVyMbkTNFkB3H+JDbjklxg0wZbjvd6hNzy
         g93SdPbBclB7axCrg5STlxA7BqOalPfw8wYxcfr/bW3/wSBZKi0fp3rpNmKO/o45z1PI
         Cg2+k2HXOL0GolIurRlkrAFmHI1/HYrBK784s7uTCFqogBXPyo8J7loHJyhsUygEw+tl
         fodw==
X-Forwarded-Encrypted: i=1; AL+hErEQW9RA75i/JE7iLOJMOZVcDekWE6u/Nh0DEDSpbMiq2rAH1bRRZOAmFcqAexgSc72VM8QUv8OzMkcOQX9S@vger.kernel.org
X-Gm-Message-State: APuU4Z/a20xoah0D5AaawtVl5A4zyGdkViaySRLvQukmHiNPUz9VWBDn
	As2Fi1mxCJvTL33nBWI9O8n8xInzTegbEeYN5RQttAmsFvCVr4HPk901
X-Gm-Gg: AYBFou2sq+Koe+GskD2Sk1+c2bm+TmoudGhYLGECwT5DyQbb/+vGk3ZXgiw2SYU1C1M
	IAB2VIT75AsMpLczxmMUQrVpDNC388jsMBZ+YfQ2TA1uJYJSI2iCQxXY8Ly9LJRc5jHEoZCVrqE
	J8zOMXHWFj3vX3KH7dWgbY/x9lab3pfr3/Z+jp/ki9uIA6wiJJ4b078BETrMnGnscqHeQNbolin
	XXDdMqq/KEFoemwAc/aqdAsGKs4RHCYu/d47vSqObEwCdXzlp94zYWs8R2A3j85V0EreLo8QpKs
	3WCcmak8bcNquZQ+W2thb/tDnHdQFC6Z7f4isUrXkTUjCmzDp3eZMYUdKGhI7UVDQKrVf6ccTjV
	wZuAT1hL8duftAqW8IPwADEyB4vTR1MVKL9qjzlCusYOfIOBWGE5kQjbwXZJJiTIhENO01Er4E0
	Zx9wQdIcrCmi5lWRCH54YxTYKwUlwmupbzoxwZsejPGp6GaVliKQNgW4sVbfiIxNdxmynj0N0Ty
	FC7k5miBnAfrHKfXYOe1IclLE3JlD/4Hl8CYwIJadaCnZXwWEnXNKur6FTu0WJm06uuBodYmfga
	J0etzAr0pJWSZN1ujALXYYUAinj0AlLURGxsU4Qillw=
X-Received: by 2002:a05:600c:4e87:b0:4a7:6bc7:f778 with SMTP id 5b1f17b1804b1-4bb88938d38mr55542695e9.30.1795168119561;
        Fri, 20 Nov 2026 01:48:39 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f635ffsm45137535e9.4.2026.11.20.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:48:39 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	eddyz87@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [RFC PATCH 0/2] security: Add pre-lookup pathname open check
Date: Fri, 20 Nov 2026 11:48:18 +0200
Message-ID: <20261120094820.11929-1-tasos.papagiannnis@gmail.com>
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

Some security policies need to inspect the original open pathname, for
example to report or block suspected path traversal attempts. A resolved
pathname no longer preserves components such as "..", and requests that
fail lookup may never reach a hook exposing the resolved target.

Today, in Tetragon[1] we capture kernel-copied names through
getname/getname_flags probes and correlates them with open
results. Enforcement additionally probes do_open and passes decisions
through BPF maps to the file_open LSM hook. This requires correlating
state across several internal probes and the enforcement hook.

This series proposes security_file_open_name(), an LSM hook exposing
the kernel-copied pathname, the VFS-selected starting path, effective
open flags, creation mode and lookup flags before pathname traversal.
BPF LSM programs can inspect these arguments and reject requests before
file creation or truncation. Existing checks on the resolved object
continue to apply.

This is submitted as an RFC in order to get feedback on whether the
proposed LSM hook is a reasonable addition.

[1] https://github.com/cilium/tetragon

Anastasios Papagiannis (2):
  security: Add hook for unresolved pathname opens
  selftests/bpf: Test pathname open enforcement

 fs/namei.c                                    |  15 ++-
 include/linux/lsm_hook_defs.h                 |   2 +
 include/linux/security.h                      |  10 ++
 security/security.c                           |  27 +++++
 .../selftests/bpf/prog_tests/file_open_name.c | 103 ++++++++++++++++++
 .../selftests/bpf/progs/file_open_name.c      |  56 ++++++++++
 6 files changed, 211 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_open_name.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_open_name.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

