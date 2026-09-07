Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76E3FC5BE
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763307; cv=none; b=huP6LbeZDu0uKKiB1YC5yb+kevLuDs3qVfkTQiY2oYF/dIeU78xKIgLo5uQmw0m4xuJriZGBHTC46t05OWPK/ym7Ip9rxvfm4vEcqMIuzHeBeapaCotzHMYT6mUEyb7pKDkmPWdPrr1vzVqaOR6vTD4LcHwHpfejHDqSaVH/uIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763307; c=relaxed/simple;
	bh=HYQYm7Ol+ajDdBWB8eOE9bTzmYQUN/ysOtKPbk0gEOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EX8pDffeMN7EHHEo675RvpizbLilO8a3tTnpOh5TJbGe24p2qtnNFFxVbyYHavbzA0v5DD9ibP59f/Bw+//kwB5C/JsLT8j35KKPTratt/14HR374zYfECymQEK7qdeC+iILbl7hzHRVQByIE+yf5dGZRrJ6ipHJMNxmuJwcSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCoMdSi3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCoMdSi3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398b3d66515so3065160a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 23:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763305; x=1789368105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zflL+q58grc4cagGW8mHiAFMNdUiRsMqNFtJfF7Dmyo=;
        b=XCoMdSi3c4YjOmIc/sur3cFNq1AvOqkdb+tGIpYoz74r0V1Z8RY9sR4YTs0dDd8WWo
         5y0Xk+/kCDlfF0T9KerCa7DzftYkq7EJO7RErTOU7v0clnI8TR23SMCrLKSVsxbbHXee
         /LqrAJTKxoolta6oUyvZUwoAWZ4VT9CDPuxhQOfiwPcsSR7t8ZtBblwqJVPNSZsFOLo7
         Zx6zuL5D/f+Wm5kHFe+LBy++U5iJ32SX6WUbDAoj+PhmOPR26RZcXI1JPMhkKyvXqrNw
         BYM5aH2rkcwiNTX/uxAsO76DJB0YzFMoEYNJMW02kTP82EEaV6Jl+XpZ5cQYUhBcKtb9
         HBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763305; x=1789368105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zflL+q58grc4cagGW8mHiAFMNdUiRsMqNFtJfF7Dmyo=;
        b=HuvnvWWjbaPc2sjXqElvVTx4GLiOPteBt6EaK91Vn6aDCOVnELP2YgB7l6xFkHJG+y
         F1KVvi6aCrw9QVo6oWzh2aXcO7vzF80r9YPl2OsWRwr5bQT4fGV8/aLN/0y7VOI6XJ5u
         Mg7ntNFO7940vgmHoJYBBjRrNzJl72TjT78ryDU664e4nb+KHT5Z+kaCyPIVjV7otbN1
         EjZfesOR/OhJiivEBUuYvvxm7d2yAkRGir24RvjZNELqBnUnbEhFw9b5KVcmtQ72kXhb
         cz1KJd76If9/ZTjQ8OPgd4A/phanv1QVchq34X54n7syDvX/bajJ+GB+qsDZWD0wcRsN
         3vYA==
X-Forwarded-Encrypted: i=1; AKwUvBy2EpvLUEIWExxCy6nouOyf1CBCMhRyFGCkRlsOY6PhykC7GqIMBb/JRtkS+2obt4VRXq3zchYtXBoBDkk/@vger.kernel.org
X-Gm-Message-State: AFuF++nTLtciP5RFxlHoI6kYsk6YWaBetLkk2x5z7nVpyLUAzATGyhaa
	ZV/V3l5H+cacOwY9ev+ZRUf6EDWiBaHJe7QCmmGFtuN6hHC4/EXIk9ow8cswt2Fb
X-Gm-Gg: AYBFou2um/aJG1IAuMJHzWPBt0kFNWnAigcChYXlVlOskZbtR52Ir/svLWn8Ggaev55
	3lT0ExJ27t3XuP183JuxSHXSrFP5kf+HnLk/zFNWeB/wtfAF/dHfV5jBHlx9hewEoe9R/s2bHli
	hsVAA9njkyMrpCrVO6dOE2FJFfmPbDJOs1fEwC2NpnJX1dRm8Q+4FYLuRhE3CQPZSMgUV2yMnR4
	PaVZKCcbGUg5asqzBpDukVgT/PDmdKFzhI15xdSanSDltgucWIlb+y4IMYyOYCkOt14I6LEJ6/4
	tJ884F2ltrHOGngeXRN4VovSt8yp4RALBI1R6yjppMi3WM3eWcUdUYRhN2suiniMTY9IjNs5Wg1
	DMsREGYF50WEMo0hfkDOyg3tBTF8okf3cFfd94NGonLMjndi44++CEvzMPCLH54tQFJLsrXsNuK
	tl7JQ1xVUMQoRWDW2cnosncPQWB9J6Owfq5zsKVsjUcB4z0gTEeuMgTMRNZa6/Lnr0/Nb+1AfVf
	k5vgtKkvJ6JIw==
X-Received: by 2002:a17:90b:2f87:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-39b260fe42amr31090592a91.5.1788763304914;
        Sun, 06 Sep 2026 23:41:44 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm22413038c88.0.2026.09.06.23.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:41:44 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	x86@kernel.org,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Ming Lei <tom.leiming@gmail.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 0/2] selftests: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 12:11:36 +0530
Message-ID: <20260907064138.38689-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corrects 2 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (2):
  selftests: fix typos in comments
  selftests: core: fix repeated word 'and' in comment

 tools/testing/selftests/amd-pstate/tbench.sh    | 4 ++--
 tools/testing/selftests/core/close_range_test.c | 2 +-
 tools/testing/selftests/proc/setns-dcache.c     | 2 +-
 tools/testing/selftests/proc/setns-sysvipc.c    | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c     | 6 +++---
 tools/testing/selftests/ublk/kublk.h            | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.48.1

