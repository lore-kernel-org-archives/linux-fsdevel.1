Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85C2DCF45
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031192; cv=none; b=FL1UVvlUjfeD7v3Y7LxqCnpd+RGmAirvVBwd6Mvc/B2apUfN3UDS7M2qkUk9lvp6PmjJilUqkcHFB/zgQLlCgbNBVtlHcz/9KZZH/m7V2f5TbalJF8FlT3uupszAThKoFHjbJjDONOOry9PRJkwtM8wZXF6NW5b57nnsMmZMI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031192; c=relaxed/simple;
	bh=V3YxaUW1sPWThpGWmjATD8lmnTcJhgQ9dTgnqCYXVXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLDuC7TReyiO9BPNZ32x+1wkjBHk3KR3HrbA8D/hx12KGoi8+JIMQgG71fzYPHnmJMgdcmj3uZoBPYnk+mb0lLJauV0ZAElG5vfmr3nBIkPHx1WY4lnnvssOPK0awoN+8UHup1pbiWpVf5XtRHqAb2muYMso11xWrWuZMRNVoDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=hQ+bPqb3; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="hQ+bPqb3"
X-KPN-MessageId: 36d5bd61-3fd3-11f1-afde-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 36d5bd61-3fd3-11f1-afde-005056994fde;
	Fri, 24 Apr 2026 13:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=SoRe13GzkUOhP39pwRBONFGVVtD44HR9B2fP/ByugbQ=;
	b=hQ+bPqb3KS0y0d75Qi2aJ1QyCRg/2Gf9p83vTxI5q3ozuiVKYmGgCp4OiTAFGIdv24J1HCa5puNl5
	 QXr4xovM7kOowvAaRs7Arvr7K1DBZLan6mv2maDrNr2YoauKs+wYM6cfN2XzPQDg2+cBCW4Mt191KO
	 upQ2dtPnHiSMXoDLn51uy4EXtUY7YlFWkBGNcyCKTjThsj8oMN+ujzraGQrlH+CJws/KJ8CBoXFyR5
	 8QMc/2lyfDLmrC87iux7Hp6mqfflMMlLvpjh7drraLiG322qU5tlDFX+ah9YuQvrtYASyD5UMhxYei
	 MzmYXel1/3V4OqRHXWYzjXLS7w6jl+w==
X-KPN-MID: 33|6WDnBHetWYt/e4CjV8eG2ox4rHsssm0taleyNcmskNRUfyEo5h1mGxchsSns5u0
 4RcjyqKiibs8HwZTt+hQplA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cNwxFqpz41/vatA/UOyNsNQsfnksbEiEEsw7yn2DCwOdSFjMChQWxsZaSPRpZwG
 fv2AhPYxC/738V3/KzWVJaQ==
Received: from daedalus.home (unknown [178.227.109.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 33f6f759-3fd3-11f1-9c0b-00505699d6e5;
	Fri, 24 Apr 2026 13:46:21 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v5 0/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
Date: Fri, 24 Apr 2026 13:46:01 +0200
Message-ID: <20260424114611.1678641-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

I've rebased this on vfs-7.2.misc as Aleksa suggested. Also moved the
O_EMPTYPATH bit to 1<<26 to avoid conflict with non asm-generic O_*
flags.

---

To get an operable version of an O_PATH file descriptor, it is possible
to use openat(fd, ".", O_DIRECTORY) for directories, but other files
currently require going through open("/proc/<pid>/fd/<nr>"), which
depends on a functioning procfs.

This patch adds the O_EMPTYPATH flag to openat(2)/openat2(2). If passed,
LOOKUP_EMPTY is set at path resolution time.

Jori Koolstra (2):
  vfs: add O_EMPTYPATH to openat(2)/openat2(2)
  selftest: add tests for O_EMPTYPATH

 fs/fcntl.c                                    |  2 +-
 fs/open.c                                     |  6 +-
 include/linux/fcntl.h                         |  2 +-
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/include/uapi/linux/openat2.h            | 43 +++++++++++++++
 .../selftests/filesystems/openat2/Makefile    |  4 +-
 .../filesystems/openat2/emptypath_test.c      | 55 +++++++++++++++++++
 .../selftests/filesystems/openat2/helpers.h   | 35 +-----------
 8 files changed, 111 insertions(+), 40 deletions(-)
 create mode 100644 tools/include/uapi/linux/openat2.h
 create mode 100644 tools/testing/selftests/filesystems/openat2/emptypath_test.c

-- 
2.54.0

