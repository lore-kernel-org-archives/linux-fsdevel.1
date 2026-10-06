Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36849C4CF
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301484; cv=none; b=e6LQNEMtoM8SIYlSGPcV0t083/XYtBPLo/HuZfryhr1AyAlR/LVsFO6IXlUBLcrgUcYuHLWQlNrmvzPxSgq2yfc/zNNnRlqovQV04OnxAQjvY+/jtYrxCrPsafPxojgCxFKPa4ocs2GsEAL8RjFwsqiaoOzrrTgJz2K4BVjMqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301484; c=relaxed/simple;
	bh=OqvqQY/IhC7NWo4o7gGhk0MEeJ2Xat8IfeE3dy9I0P8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pmWmHnGpH2PYHQVMHxIpwZdg+wIpfsfFtBBkN+9NJJ9hzJ1aQH1e/U8NkG7Lpcvix9BFzgx2wicudOpKyHTSq/MmWs/u7GYSmR+ReDdJnbMDk1cD5dZ9ImOBN6BvMlFUwCrRjNlhIkOmovf/h6Zh1yLKKfiDb4O7hmKbbwC2KYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ELlfynIt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ELlfynIt"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53519e20d7bso26499011cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791301482; x=1791906282; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IU49nZZhlVu2qJsiPTHVpkbTUnb5Udm3WFaqPCSBC1s=;
        b=ELlfynItz72JPceAe9hntvezZXR2T2hVu0YMz5K07CIqgUSeLKOKX3ARovmUYllYl5
         yYlhH5TqWT0Lm6/2wu4Fpa1wPiflj+ujFshqoJI6w83lxe4CQxkiVydPfuTIrpFNNwtN
         /kE3qyJnGqTwT6bdRhsv/3AnJJdkNSwt3HrDb1igGrLi4CxEHEKMi5w4BZOjBxStGtnq
         WuDsBB2RZ0GSqu1amqZYgNm+KtfF3lej78g3JVp66qHXeD4At/qEJU31gYMFXzc9Im/D
         o9V0DbXxuFc8khY9+w0gwrc4uZPIfIcpPw9AoJLhabmZ9Plnm0jbA/DujfXmk2PzMKOc
         fTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301482; x=1791906282;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IU49nZZhlVu2qJsiPTHVpkbTUnb5Udm3WFaqPCSBC1s=;
        b=VnMq08pF6aTBtownv65zpoJOUYxh5Ek3zSR75fCNlzX+ExHLfxUc6S89yebiLLuMmk
         1ycvhcr3/BX74aunOV5sczXPhUVWUSPxghdjENWIgCempeplhWMsCe0QvRFFtI9GQ1PN
         DFwTeCoW4yTudmytMyuTi8OrJcYEiPiuMkCfTGPo9S6jrhmmn2q7nG3QFUg825zwPKnT
         fCPLPhKgRU/IYeghFecBszk8guWCmIklAsD0YjZybG1q8WTh0fHlN+LXlroEBGkWL0Cz
         aGNAzpRETkYJhN8ugfKLoce47R6YUxM1l5J3O0lp41ja99VmvjmYkpVxUuIBAa1+qlED
         P4/w==
X-Forwarded-Encrypted: i=1; AKwUvBzTbCZMbkPRgsQuCR0ewlG53bteMLnYHdHEJ7YX6DJiybL1CpkdQwmiO6/3IWv5UnSiuH48ebyMKOx74mWW@vger.kernel.org
X-Gm-Message-State: AFuF++mHb08gdvOju+9ZLoWsvxIXaonRJzONLAZWYDGX0mYrU0htOCzb
	xkT2fiZ99dvHdccLoJjxI8S6x5bYiJeXiPdtU5kMz8d5B/0MI3mqCy4jgjCS0RA2A5s=
X-Gm-Gg: AYBFou3yAlZEkLHseDzoZCzZ2SnTcq3Uu42ppNPZz2AWWeEIiQqitmz34WnkSzydY6d
	DpxNFUfqslDcwecu29DSr9XUxLgL0SM+OUSbRq5/rg8eLkBeSEe/+9+rVxruLExpYzKQOzw5dD7
	NS0UWhSF5yqJ3GIRb7P6C66dsV410vowlYqPOpT42sFeLXUdmBGuWPhnu0N21PnV6kiHGt0hZet
	mZan/ro/qhBz5I74aVXgGdgmRyFg3f3vel5DoXCUZiTi93josNVvOGj8awtisSswwuzd6pfn6Bh
	wtPaybfgNlik6uRZSVMHVXwQFpiyA8ocj8b6caXnxXaLKkWbt1w+WNPC33JTOJ3L2ntndpbA8zX
	uzayJHXbYVVK0BiIYPr1sJaqyAcial77IUWd+qWyqy/DFiQnv8GFlVENq6xfwm6xPYsc4zql/Qh
	DtXqd/e3R2rjnS+mbM7BLF2rWp6nLvHUwcpOTyabWEwwnxE9cHVZCwUg/8AnpAymZxCPiC9hNqT
	RzkTZJQ5eBgp5MZ0lLEIcLWqw==
X-Received: by 2002:a05:622a:1f13:b0:535:1e6a:1f0e with SMTP id d75a77b69052e-53566d8e3cbmr25469741cf.27.1791301481707;
        Tue, 06 Oct 2026 08:44:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5339883034csm124897031cf.3.2026.10.06.08.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:44:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Tue, 06 Oct 2026 15:44:16 +0000
Message-Id: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFEXxWoC/1WMQQ6CMBBFr0Jm7YSWYmO8imHRDoPUmNp0wJgQ7
 m6LK5fv57+3gXAOLHBtNsj8DhJesYA+NUCzi3fGMBaGTnVWK2XR9yi8TOQSrsWNgqM1+nJ2RhM
 bKF7KPIXP0bwNP5bVP5iWGqoP74TRZxdprtMztb5vj/E/Dfv+BR+OVX2hAAAA
X-Change-ID: 20261006-b4-setfcap-userns-d63185a31ce3
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791301477; l=3293;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=OqvqQY/IhC7NWo4o7gGhk0MEeJ2Xat8IfeE3dy9I0P8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFGH3nAizFspoz6WknfBOIRo2rktqxme/IK9Mf9Wqf0+sIV0rpomF8WzQ+ZmgB8jxmltOol3zy3
 G5R34oa49qgk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
stops a root task that has given up CAP_SETFCAP from creating a user
namespace that maps uid 0 and then writing file capabilities in it that
the initial namespace honours.  The check only looks at the task that
creates the namespace, so if somebody who did have CAP_SETFCAP created
one, there are still several ways around it:

- setns() into their namespace and write uid_map from inside (patch 2)
- write "0 0 1" through a uid_map fd that they opened (patch 3)
- setns() into a namespace of theirs that already maps uid 0 and set
  security.capability there, no map write needed (patch 4)
- ptrace one of their tasks and have it do any of the above (patch 5)

On an unmodified kernel we took a uid 0 task with CAP_SETFCAP dropped
from its permitted, effective and bounding sets and, through each of
these, ended up with a file that a uid 1000 user execs with
CAP_SYS_ADMIN in its effective set.

Patch 1 adds cred->setfcap_level, which records how far up the
namespace tree a task's CAP_SETFCAP reached when it entered its
namespace, and patches 2-5 check it.  Patch 4 is the check that closes
the class, the map patches make the uid 0 map rule mean what
db2e718a4798 meant it to, and patch 5 keeps ptrace from borrowing what
the target is entitled to.

This does change behaviour.  Everything new is -EPERM:

- a task that entered a namespace without CAP_SETFCAP outside can't map
  uid 0 of the outside or write fscaps for that root user anymore
- a uid_map fd opened by a task with CAP_SETFCAP can't be used by a
  task without it to map uid 0
- if a privileged task maps "0 0 1" from the parent for a namespace
  created by a task without CAP_SETFCAP, that namespace can no longer
  write fscaps honoured outside
- PTRACE_ATTACH and PTRACE_TRACEME fail when the tracer gave up
  CAP_SETFCAP and CAP_SYS_PTRACE, the target didn't, and they share a
  root user

Rootless containers, privileged runtimes writing the map from the
parent, nested unprivileged namespaces and containers that don't map
host uid 0 aren't affected.  The ptrace check is one compare for
targets in the initial namespace and in namespaces entered without
the capability.

Testing: a set of flows run on the base and patched kernels, every
bypass route above gets -EPERM with the series and the 16 legitimate
flows behave the same.  The capabilities, namespaces, ptrace, pidfd and
proc selftests give the same results before and after. Thanks,

Josef

---
Josef Bacik (5):
      cred: record how far up CAP_SETFCAP reaches
      userns: don't let setns() lend the right to map uid 0
      userns: check the writer too before mapping uid 0
      capabilities: limit fscaps to where CAP_SETFCAP reaches
      capabilities: don't let ptrace borrow CAP_SETFCAP

 include/linux/capability.h   |   4 ++
 include/linux/cred.h         |   1 +
 kernel/user_namespace.c      |  40 +++++++++++----
 security/commoncap.c         | 119 +++++++++++++++++++++++++++++++++++++++++--
 security/keys/process_keys.c |   1 +
 5 files changed, 150 insertions(+), 15 deletions(-)
---
base-commit: 7909a3e30a05e40bbc8bfb7f5629ed642abeaab8
change-id: 20261006-b4-setfcap-userns-d63185a31ce3

