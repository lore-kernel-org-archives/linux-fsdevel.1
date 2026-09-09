Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625533A9DA9
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951027; cv=pass; b=YoIdvRW2/zIGxppPNq7+3j5FQtn24K/t4/53Ie258MWPWGQ6e4GtlQqwg7WYUgrQgVL84Cn9AEEpvct+kVOJ4e4XYzHPGBJaNZoxzZP0g1+N4KOXHeZhRT2eOWPZgmCAGXbChDD9toCMdTrN6qY78X0TI/3/YhnWJs1CwPC4EWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951027; c=relaxed/simple;
	bh=j6cZDBgYeH1UDdB/vYUO570Md1Mq2XHTWTYhQ5j6hzM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MuHJnD513wB1jqCGsi0wT+ieP5MGxYlhdOixt4LJRviwjrrfxBPUX5v+EBBaLptpXRy0hJ1eoUtjWiZMHiCrzgvpabQANqGiY2xL4pmRutzTZrTUzYxLRI7zbD9laU97AnDhOT4LFTPXmD7g7Uc2cgAPkhG6zZ7cVzEVIOt/GYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX/tOI+g; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX/tOI+g"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e2540eso34610b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 03:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788951026; cv=none;
        d=google.com; s=arc-20260327;
        b=P/LDenAXWP1WQ3YpjNyMH+E+3nL02W1pDSZuSUme7Y89FglZFyPf6F2i7cFcX2dWE9
         J97BGqVqTQ9gG8P79vaLi+KItb3TG5XD2hbuCXbQl7tzaXsCj6UWsmyiNrEcwRWy7Wpb
         7zShoPbhFQE6gDCVpanatvFQeJ0P/55LVRkb6rG4EomkZLPk2NU6CebEUalfEJ5/y/Bo
         0pS0hfQ9qZx2JFD4p9TWUPBOufAWScLPXpp44D68ymG8W8JoqWJ8dJ0s1UX23AFd+640
         EetQSAxhAn8HcDa53bNg3gcT6kDE5NKfHB5wTGPvHUyXpViDm+SRGS4lZmLoJysAYjCf
         ZX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=SR3OnMYhSgT26cUzIvbzCnCc1HtdUMyjPk0RDj95K2A=;
        fh=s9o4IjE+sZMlNvwWtkdnLGk/iexpemkKTjln3jgTd7k=;
        b=jdlrAzu6TG2Sd6JeZWC9omwX9RdGLaUhdepbVu/sBkJwYDTwUG14L0gnM5P1TJSOPb
         qlqlUqDajylBjIBlGKiqqGaaxGEgxRW4hBYOEI3THLSl8iPRsUYJ1OGuhu91pnXRPfWP
         xYu7LO2dn+cok4GL6sPI2Z6D+5vzDNv4InIUYWATeXbAdY/TEiNLSX05Hx87Ce1mpSU7
         aooF9LQMcFvkydYedeJakPEKJZQfTBJjfEa7a5LlYrGgCcMta7onRqtiQdVehZlUB/Nq
         CC1xsdmBjHS6Wn6OpwYJKETMfKWBsCUcnmZsiuiy/Mntl+60CfKrCGwROxu9hvgKcg+r
         Gnhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788951026; x=1789555826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SR3OnMYhSgT26cUzIvbzCnCc1HtdUMyjPk0RDj95K2A=;
        b=KX/tOI+gOhYOae0P+LfG/tdV98xCOtYs5Vobyg5bwKRLYdLGrx2eplUPLeQHgYJpZy
         th4V6Ate2kj5k39s/pLgaBGr36MIq+foT3ky8FSYIqgje8GVXv/MN25A1qh0bHGUM/VT
         m6568PpLkmcTvDJCjZE0dZCJsesuVVlmew5y2FqnsyRnlH31pWhr1xf6yaGLIrOhWW81
         7NG1AtmQcIYzBlG7uGNp4xkr+26jdNFMFzJiZ8mA8Jga2bifBDT/FnTA5yZZlesGwaw1
         dv6UTWDaYDRbRk4tt2zpIi9V79DhCD8McR4jFxnSdGzuU1mGQtbDuL+ws74Ns4JUoWbs
         VRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788951026; x=1789555826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SR3OnMYhSgT26cUzIvbzCnCc1HtdUMyjPk0RDj95K2A=;
        b=TJ+06kq6nryNFI8uwQmoDAMR4OwQpIq57cTSHluL0ql+9mcJfEOU0fxzUNzfH0lomQ
         ZNTJvpjQBc/uNGY0SZSgdnEgaaY02SnAH0mRGe6vIUMwc34jXBECOuN8oWVlhDJM8TTC
         iYf+YWTTl4lwx48YtWKjg5sDYJv9ocXtlKxcc+aTiLDu8t0LLukeM6RTnajOr9sQs6WH
         TwyPYvX0xVkMir1ak43Ax7Hvf2ZEGr1VBlxmykq4+GI9WdOUo08qpnXNg2yARgQjQ1w+
         /1glbD4xQCLkTxB2E2ExQfb32hYl77AD462BALhI1UqzmbY0yWDUzicpHeJCRKWmzyJM
         BZJg==
X-Gm-Message-State: AFuF++ncxLPI+0uc1Zha1LuQlblCneKY/L6+aUd2zFgy463YdMncnWqH
	Jz6Tu4dPH3uNKH9Eus8vi2jgC2VC0Jxu0CfnFGE2NSqsxqQQR5GUE2Fwhm8nHo2Lts9pBUNXwNE
	rl+IasEGIobbVKPjDVGi7Jp6pjMuuMYuZhJQRo8sNFQ==
X-Gm-Gg: AYBFou2g2qNUBupeTqJmXXIUvJbr3FiLvwhRfO6o7TaUd+aGLQoj/s9w5Wt20Kvs5JG
	VwCb9/oKVJW1ueRI7Pf3gtU+DZXSBzlr94fs/omnz80F6ECy+OYj/peRbLOJkD+9DNQxuQM4DtN
	YTDWGK6N9c3G5KxR3Q9r0PcuzBZze73brL4m1/rSxmGJQZVzlqw6mktomgdJYGDLnfixOy6fGlt
	dhn6nHHBoOkej/Z+elrHDSAWJDRH6KdNoh5p5zFCdqnckE6ZmEnLrAkqXbeilU9+lM+ZSQIciEM
	RLmh+ZFgvu2r1uphQQ8tEe7XWEuzUJBYoxeIE+fau8vizgbsyWCzIetB
X-Received: by 2002:a05:6a20:6f0e:b0:3bf:63af:855 with SMTP id
 adf61e73a8af0-3dacbd26702mr610907637.1.1788951025558; Wed, 09 Sep 2026
 03:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?Tmd1eeG7hW4gVsSDbiBUaeG6v24=?= <nguyenvantiennani@gmail.com>
Date: Wed, 9 Sep 2026 17:49:26 +0700
X-Gm-Features: AcwNN1WxGOQ9bY-7r0846Zbm3ObMObeofeNrISt_TglaNc0pGuiuzJzE2Ktbgps
Message-ID: <CAKT34MyyF5iC50agYpMMb4sOXYZ=n2Z77PV+u=TWsSTP0YdS8A@mail.gmail.com>
Subject: [BUG] procfs: fdinfo permission and read can cross a setuid exec epoch
To: linux-fsdevel@vger.kernel.org
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am reporting a possible procfs authorization/use consistency issue for
maintainer review in Linux v7.2.4. This is a normal public bug report, not =
a
CVE, exploit, LPE, or claim of confirmed high-impact information disclosure=
.

Affected source
---------------

A clean Linux v7.2.4 checkout was reviewed:

  commit 5015d0d945b3d3f2b038d2667880d5762f7d9437
  fs/proc/fd.c:23-73, 85-101
  fs/proc/fd.c SHA-256:
  5aba6d410e9aee3283b9007e33668a99f5d4c506deffa8b9816be415966eca0b

The suspected check/use sequence is:

  open /proc/<pid>/fdinfo/<fd>
    -> proc_fdinfo_permission()
       -> get_proc_task(inode)
       -> ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)

  later read of the already-open fdinfo file
    -> seq_show()
       -> get_proc_task(m->private)
       -> current task->files/fd lookup
       -> get_file(file)
       -> generic fd metadata output
       -> current file->f_op->show_fdinfo callback

The permission callback is not held through the later fdinfo generation. A
same-task setuid/setgid exec can occur between the two operations. The proc
inode keeps a counted struct pid, so this is not being reported as PID reus=
e.
The task/files/file locks and file reference also appear to protect object
lifetime. The issue is that the authorization result and the subsequently
inspected task/files state are not visibly tied to one exec credential epoc=
h.

Impact currently established
----------------------------

An ordinary local UID can open an fdinfo file while a same-UID target is
accessible, retain that open file, and read it after the target executes a
setuid/setgid program. The later read can report the target's current fd
metadata and invoke the current file's show_fdinfo callback without a new
ptrace authorization check.

The generic output is position, flags, mount ID and inode. The v7.2.4 callb=
ack
review covered eventfd, eventpoll, inotify/fanotify, pidfd, signalfd, timer=
fd,
perf, io_uring, sockets, BPF, FUSE, XFS, DRM and other device callbacks. Th=
e
observed outputs are metadata/state such as counters, masks, IDs, inode/mou=
nt
identifiers, file handles, signal masks, configuration and accounting data.
I have not established disclosure of protected file contents, a reusable fi=
le
reference, credentials, capabilities, a kernel pointer, or a reliable
high-impact secret. The stronger public memfd scenario for
/proc/<pid>/fd/<fd> is not being attributed to fdinfo.

For that reason, the current classification is a conditional security and
process-observation candidate. If the output is intentionally allowed to be
stale-authorized metadata, this may instead be a procfs consistency or
hardening issue. I would appreciate guidance on the intended contract.

Safe contract evidence
----------------------

A disposable v7.2.4 debug KASAN/UBSAN QEMU test opened fdinfo before a
synthetic root-owned setuid exec and read the already-open file afterward.
Both independent passes observed the eventfd callback:

  fdinfo_eventfd_callback=3D1
  credential-epoch-proc-contract: PASS
  trigger_rc=3D0

The same contract also observed post-exec status/cmdline markers, but those
are sibling procfs observations and are not needed for this fdinfo report.

Frozen logs:

  evidence/credential-epoch-consistency/proc-contract-smoke.log
    size 25227 bytes
    SHA-256 D34C9587A2692830BF118887131D50DF773C5C1B108FDF593B821938E8E48CC=
5
  evidence/credential-epoch-consistency/proc-contract-smoke-2.log
    size 25163 bytes
    SHA-256 BFFD6DE0C3C64F6A9B68347359DF83B7A6060103E4B65F14E3222FB6DD6C8C4=
9

This test demonstrates only cross-epoch synthetic metadata/state observatio=
n.
The setuid helper is synthetic and does not establish a production privileg=
ed
daemon or a high-impact disclosure. No race amplifier, exploit chain,
credential theft, namespace escape, LPE, or kernel diagnostic was produced.

Questions
---------

1. Should fdinfo authorization and current fd/callback state be coupled to =
one
   exec epoch, for example by read-time revalidation or by holding the
   target's exec_update_lock while selecting the state used for one seq fil=
l?
2. Does any in-tree show_fdinfo callback make this stale-authorized read a
   concrete protected-data or security-boundary disclosure?
3. If not, should this be handled as a public procfs consistency/hardening
   fix rather than a security issue?

I have not attached the source-only reproducer or the full audit to this
public message. The reproducer is a minimal non-exploit contract test, and =
the
full source/callback audit can be provided to maintainers on request. This
keeps the initial public report concise and avoids publishing a synthetic
reproducer before maintainers assess the issue.

The report follows Documentation/process/security-bugs.rst guidance for
AI-assisted findings: public routing, concise verified claims, and no publi=
c
reproducer for a potentially security-relevant issue.

Regards,
Nguy=E1=BB=85n V=C4=83n Ti=E1=BA=BFn
