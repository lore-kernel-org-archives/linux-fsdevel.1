Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C50B3264C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275557; cv=none; b=uqvKFznAu2BipBVAcx02WK9SVXeeiFXCMGm7oa47xMvUhkP75mWHJ+OIcZvo62aN9Lv59N5RQGvxUzNt5JF5ZSpgOwkgwhDCglbEuo+W8RcFb3wrFRAqZhRwI3TfdmKUH1lFE5z2X3BEyIvI5jcAwK7lo5S5Bn/sGTpnkesCfbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275557; c=relaxed/simple;
	bh=CEoIN4hbWHsWs2fIH831NCYDbaWcyrpV6r/hS58ZGD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0OGSItQoUzIbbmHX+KAe8DqA46pKXYBVOTJA1QGeYpRUrZEH8mCA3V8U+akTHLyyw1mSYLwZ/+ifxDodMws8sq7xRCygm3345tQpIM+Dpm3cr2VlUJS75xs0QfhBLvFwO4sKAuTLLHU65vel/600QoLeKrBjUsagdJwTMxRlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT4gbV7x; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT4gbV7x"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfd832155so4936236f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776275554; x=1776880354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdjcD7zkC4Ffs3/NLQJC4RJdZibISgd8Xa7t12qdRuE=;
        b=HT4gbV7xNtxcyW3ba0gVogPQUOPnekDbPGLslkFNgkEIJNepk4bqUBKSei7OFlCUU7
         rTSFM+U6OJDk9yghK5GijGXQxIdXtRSqcjzu1+/cZv9o868PRw1AnW/KArE3Bv1EDSDi
         N1kIymOORTc5zMuYVJBt2mQkSlezn4fhDrFEzscqUXqVzNWTE+ZhZV0CXAMyGR4UzWEr
         va7h+CI/B+aRYyN6feYFxuJyn/FkytuCfKl0FMWjuJaFeJVIS8ZFnsvs18MPRCrdkNZU
         Qjh8yIgHaSk7Bk/tBbGebkbKkM/W2gfZemhnxTpCYwZUHHiuflPnSuU/l/AmtxMD2cHM
         W5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776275554; x=1776880354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdjcD7zkC4Ffs3/NLQJC4RJdZibISgd8Xa7t12qdRuE=;
        b=AfdIfe0583g8iqm5UUe1FhsDPaBFCEnkdu3YpFCCSB0h5LP+FqASVujCQJwcruckfU
         2bcAVS3uS9NKpFsOVSz/ZVDWkMy/DtRf3APxPeZYbWOdA0cvwlNN4Vb6mLrnDOV9RGq2
         24ljgaVhZD9cIuW63REseqrCohIqWtHSKTZj+F+ITavIQOHOJBAxfsewV4pbq0Nns6A5
         H2J02+lgStl/BQ43f5uENo4mo5vJ0KoFAy9yAIlgvIPvguDoVagfM3mlg+vrfRIjylDi
         MbEaMJy6SlKBD5b/Z50S0Uss53N2m/WDBcbPk5YOqfv461NaJhvicT41fsp9DQrz7Rje
         JbWA==
X-Forwarded-Encrypted: i=1; AFNElJ8FsHoPlM8Xp2P7x1sSaUDQlI4OsXshF3gaeST9UEPp8hoxW+hODxeHZpo/h41r+fL+VZbZSFugmVtSqWOl@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8PrFMsdC6gQlHfEh6EFBYBb8Pqiwd0G/3TK30rqqhs/pDWWR
	64+g3XdpPFatuNx+thexME9dOAPcbRYdjlRebBDlhUtoTCjaGq422Pbd
X-Gm-Gg: AeBDiet6Jhfpr4bBECw5LmjAMY3fyWH3lYqH8VPrKiOXX3Q87xxiksO2vc/SP+QCAWQ
	xn39whU06CN350pvTsV4NsXreQEAXUue4YBFXsCD8JodrHgBgpFkDpU302lKvdsRFxMkU+P1AZR
	o1hSQZTaLL4MwW5FQXGtD5s/BP6J/55e4WwbhRuvnUqk9lrqJSNqRjLIasHV1d7/Rn6S6XYc2Pz
	9oztHXIlBbcscdbCcLa/D/bautvinv5yYgX0/zwniB+kHLcQRlVv4U9NcnYq6Gbbiqx5oBhC7qj
	t/Es0GZKqjPeVQLGYr4sZtVfEWfkPnIgmHet8lbHYSt9GNEvXTkqQ+6QrntseLS5ObcoIQbSucO
	XfNwEWzPdw9J18AFeyXkLPHuZkeSywygYff4xwse0DCmPt0RRlnNTAK8qon0Q/RnuwMf05wZzE4
	5yqojfMbVlT7XSMkgp9apxdGqmXD1QcVDWNUv9SRWNxvW+dzXsesMTKMljumfZGmN4/r2+
X-Received: by 2002:a05:6000:18a6:b0:43d:77c6:be6e with SMTP id ffacd0b85a97d-43d77c6c5demr21547074f8f.31.1776275553408;
        Wed, 15 Apr 2026 10:52:33 -0700 (PDT)
Received: from x250.speedport.ip (p5091f01d.dip0.t-ipconnect.de. [80.145.240.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d6d3sm7166741f8f.8.2026.04.15.10.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:52:32 -0700 (PDT)
From: Myro <mirademche@gmail.com>
X-Google-Original-From: Myro <myro@myromyro.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Myro <myro@myromyro.com>
Subject: [PATCH] docs: proc: fix minor grammar and formatting issues
Date: Wed, 15 Apr 2026 19:52:30 +0200
Message-ID: <20260415175230.46721-1-myro@myromyro.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missing "from" in "prevent <pid> --from-- being reused" and
add spacing in vm_area_struct range notation for readability.

No functional changes. :)
---
 Documentation/filesystems/proc.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 873761087f8d..d828006bd91c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -118,7 +118,7 @@ PTRACE_MODE_ATTACH permissions; CAP_PERFMON capability does not grant access
 to /proc/PID/mem for other processes.
 
 Note that an open file descriptor to /proc/<pid> or to any of its
-contained files or subdirectories does not prevent <pid> being reused
+contained files or subdirectories does not prevent <pid> from being reused
 for some other process in the event that <pid> exits. Operations on
 open /proc/<pid> file descriptors corresponding to dead processes
 never act on any new process that the kernel may, through chance, have
@@ -2199,7 +2199,7 @@ the process is maintaining.  Example output::
      | lr-------- 1 root root 64 Jan 27 11:24 400000-41a000 -> /usr/bin/ls
 
 The name of a link represents the virtual memory bounds of a mapping, i.e.
-vm_area_struct::vm_start-vm_area_struct::vm_end.
+vm_area_struct::vm_start - vm_area_struct::vm_end.
 
 The main purpose of the map_files is to retrieve a set of memory mapped
 files in a fast way instead of parsing /proc/<pid>/maps or
-- 
2.53.0

