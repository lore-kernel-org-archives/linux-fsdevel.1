Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37196356A12
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023726; cv=pass; b=qL4L4w3FE7KGSxe9eFAUEF+peUlpJn5pPlvVyF1JbKaETWFuflJHEXf2ohZgT0NVdb9ZkZH4AxB0x4HCLhiRtLgUgl7eojZ+uPvN8BcXH47JMe4EBDRXI4nyi6BnyqiEm2SxA3M8RRtFMld9vv8wjgjwPCAGhdkY2q9SJKsJVAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023726; c=relaxed/simple;
	bh=PhbkiiXnaQtPHs+QENpGWUrWihXPX56gpz59fEyngzk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kGb562zhvb2DBvPaq4xX+JlJ+G44h02+ISrbx75IVHaN6YD528NeDZtD/u3UnTS4ScaKQrXpREDROYq28IyvPOQ7jQKofGRpyQxug1kudV2//qrdC8whqAEsIWlzjlcArLsCA0OR0rYNL865QxQQZdGdMhp7iErVJLIjgErOT7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2UVc8Kh; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2UVc8Kh"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79fbso7844715ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 00:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789023723; cv=none;
        d=google.com; s=arc-20260327;
        b=jNL5dB5Zs50cvDK8rb4L1gkQep0UyinY6kxeZBCU17Meip3Ua7JqswwvTA2OB8meBD
         8m/qxT+FGbHLwD+Hl6z0qCyh5uIbQlHy5Ymk8C5ZCDJs2T2x5C5+5hnnkBkcs4itCdTI
         tFqCgjGtmd3w2XXGPWic9AVSUDk5XkTyEbhTsPjm+xFKpXa2LcQXNrVcdBqoFD6ygiBU
         lRrakyic0JoVuYbRf8IbVEeZ1MZCVEHYKMB+3L7hEuoxy5c2TCgow/C2d4lX8DazrugX
         gc71a0CAKq14bBPasC/ZLEihNplLPEILUTFhRfaSDjPpD6HeXX3r97RvZyBgIENlt/2S
         IV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=lqlp5XdA6wqhueSiRZkCgFLunb/yjs7h8vgFlDO2zJQ=;
        fh=s9o4IjE+sZMlNvwWtkdnLGk/iexpemkKTjln3jgTd7k=;
        b=O2uoSMCkvDtjFk5H9yytDCRepwZcyKj7M6vvrABrzgdYGXY6RzcQZYslErWBYrKcd4
         tHLMdijqurKNFLbOcZFnlENkd/SYyRPESONVyM476KlIuEYXreX2Oo25n49OMMc3OSVH
         MGVJuyk+EXModmf0DF9GdZK1rk0p6M84G/lr4DJH2zWDjIm7BeWGsSyplPZT9g+liaYF
         wUczaPeRFTjgZ0ENbGoRDrK1T9loks0E1pt2dS8ylmPooGlZcEFjC5nVglMoB1i5bC+V
         wR+SHG0wYU+BXAMQ4lf8ljHuUGntZhbqkki+KEHUmjCSgdDbv4PEcNNICgoOCJ+GOmSN
         7rNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789023723; x=1789628523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqlp5XdA6wqhueSiRZkCgFLunb/yjs7h8vgFlDO2zJQ=;
        b=c2UVc8Kh1gIG3MBvs0FwWol3khzYnWHrfAt4IQ4YxyUtBCBVmbRCp3zguEEfQ4HuW5
         lTUJ4skanNxoM4wmRqjIDB8P6b51HcENpGf+NHQ3tD/zf4gYnsqmByP+wvEzbi7CZTmc
         PiWhQuxhWvdOSZTnaEohjTvc3fgaPlscUT3TlBpk3gLhejduRMoi6Ir7e+WJYfzveao3
         pnNUY6URj2KXEOHmZ9CA1A4mA3wS/UezrFUO0CDoKsXiDDyL0SSZJ9nT2y9ez1vF0n4t
         HJ9VGDJyCbyl23nzJpt8mzgpjBGMn49sNCBDPcr2ftNL5gDEZooiSv2kTfgtfeBDt3iW
         M0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789023723; x=1789628523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lqlp5XdA6wqhueSiRZkCgFLunb/yjs7h8vgFlDO2zJQ=;
        b=YvQNwZS2t4Pe1X5HQDuCnZYC0hw0mgfD7j0kjCd4t6KGI62uDh8zLLFMaNh3z0qcVi
         w+v+Qhb1kjCpMH7ruL5FJEAmiwYIrrXgOLZtSsAjUkcR1Sq4ayFQ/NFBRbXmsqOhuAzv
         ujNQv/mH/VIp9sje2TBId3A24XX18Ky70dZx6Q40fQ8SEYaK+LNfmJk6Xcdnol+4XpLR
         TK3b/HB1o+C3nku5Ay0jCH+Eb42+flMpzBfjKUwqkVioqo8zOBHa10l1VUKGpR8sT2ce
         cNvS9Nq5HGCU30Hn8cKBkBAorpKoapRC+erCrh9LL9ohkoOeernrlXxCX+NuEgYMPrND
         mJ0g==
X-Gm-Message-State: AFuF++mpkrem68Ith4DZ3AFDEuGYWV3vUwxDNrLZsvcDgrdEOgExZkjn
	LUFtFCQ1MC6GvqVFkA0TvQM1KDuypl6J4LeyliMkK6ahtzNUJqx2LR85ifeppCRSifALDOG/BdR
	szbEP04W6KHXRlrDezISf/CFEa/ulAJZfiS4jsjW/gh4e
X-Gm-Gg: AYBFou0yANhoxZii2ySO4lQbgXqRS8ZbFDK8M2BV6XnjgDyQijwYEFrRxe1YY4bKUpJ
	IAcvhF3XvZ/CWItUpYlxvFvbyTjLQzr9kK+ZT2g+/8a1eHQ3tFA45pKJIu6BtTrj5F4PYaQ4N9F
	TD3Nk34Mr16QD7j4qdJZSfmG1eS5scQwfXgHTx3xjLUnPtR0YKpsAAyRDIYCY7zhPgLbwJOheAC
	6VQSgBo5Alin+a/mamQdowoK1E78Unvh8+A1Fp8Ik2bdqWdNK65kj4xGAfcKsve6RRn3ra60wyt
	VMzLejk69UpaWEF68dTNA1HJp0ViF4X2/ivuuK/A+mFnOu2yGEfmcthkqQ==
X-Received: by 2002:a17:903:4b07:b0:2d8:d4d3:da51 with SMTP id
 d9443c01a7336-2dd07dd6122mr89515045ad.21.1789023723013; Thu, 10 Sep 2026
 00:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?Tmd1eeG7hW4gVsSDbiBUaeG6v24=?= <nguyenvantiennani@gmail.com>
Date: Thu, 10 Sep 2026 14:01:05 +0700
X-Gm-Features: AcwNN1WWElIUY25AzJ_-gbmj9Ns0RaAsCuKruulfZYhpbAikL3WaBhSGrvaXrwQ
Message-ID: <CAKT34Mz=N82osCmXHoHP9V7knyqfeqdGDUBd3h0sV6by9dyPaQ@mail.gmail.com>
Subject: [RFC] procfs: current-MM controls can cross an exec credential epoch
To: linux-fsdevel@vger.kernel.org
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am requesting public maintainer review of a possible procfs
authorization/use consistency issue in Linux v7.2.4. This is a cautious
normal bug/RFC report, not a CVE request, 0-day claim, exploit report, LPE
claim, or request for security-channel handling.

The question is whether an already-open procfs descriptor, authorized in on=
e
credential/exec epoch, should be allowed to select and operate on the task'=
s
current MM after a later exec transition without read/write-time
exec_update_lock/ptrace revalidation.

This report is a follow-up to the related status/cmdline/statm procfs reade=
r
review. It focuses on two writable current-MM controls and related KSM
metadata readers that were not covered by the earlier draft.

Target source
-------------

The review was performed against a clean Linux v7.2.4 checkout:

  commit 5015d0d945b3d3f2b038d2667880d5762f7d9437

Relevant paths are:

  fs/proc/base.c:2923-2998       coredump_filter read/write
  fs/proc/task_mmu.c:1855-1933  clear_refs read/write
  fs/proc/base.c:3219-3261      KSM proc readers
  kernel/fork.c:1405-1423       mm_access()
  fs/proc/base.c:818-839        proc_mem_open()

The suspected sequence is:

  open/path permission check in one target epoch
    -> procfs permission / ptrace-family authorization

  later read or write
    -> resolve the stable proc PID to the current task
    -> get_task_mm() / current task->mm
    -> read or mutate current-MM state

The task and MM references protect object lifetime. They do not by themselv=
es
couple the later current-MM selection to the credential/exec epoch used by =
the
initial procfs permission check.

Observed controls
-----------------

1. coredump_filter

The coredump_filter handlers operate on the current task MM's
MMF_DUMP_FILTER_* bits. The coredump path later snapshots those bits in
vfs_coredump(), while dumpability is separately obtained from the task exec
state. coredump_skip() still rejects TASK_DUMPABLE_OFF, and the VMA dump ru=
les
remain active.

Therefore, the observed old-FD write changes future core-content policy, bu=
t it
does not itself make a nondumpable setuid task dumpable or directly read a =
core
file or memory contents.

2. clear_refs

clear_refs=3D4 selects the current MM, takes the MM mmap write lock, and cl=
ears
VMA/PTE soft-dirty state with the existing MMU-notifier/TLB handling.
clear_refs=3D5 resets the current MM's hiwater RSS accounting.

The kernel documentation describes clear_refs=3D4 followed by pagemap bit 5=
5 as
the soft-dirty/checkpoint-restore protocol. The old descriptor can therefor=
e
change current-MM dirty-tracking/accounting metadata after an exec transiti=
on.
No checkpoint bypass or protected-data effect was demonstrated. A checkpoin=
t
integrity consequence would require a separate userspace consumer to trust =
the
changed state.

3. KSM metadata readers

The KSM proc readers expose per-MM counters, process profit, the merge-any
flag and a mergeability boolean. The mergeability walk uses the required mm=
ap
read lock. These readers return metadata only; they do not return KSM page
contents. The counters are asynchronous snapshots updated by ksmd.

Related controls
----------------

The following paths were treated as controls rather than equivalent sibling=
s:

  - stat, which holds exec_update_lock around the relevant state reads;
  - mm_access(), which takes exec_update_lock while selecting/checking the =
MM;
  - environ, auxv, maps, smaps, pagemap and numa_maps, which use the
    mm_access()/proc_mem_open() control path.

The latter wording is important: proc_mem_open() uses mmgrab() and mmput() =
to
retain the mm_struct object, but not old address-space contents. In the
boundary test, an old environ descriptor returned empty after old-MM teardo=
wn
and did not read the helper's new environment. These paths are therefore
controls against current-MM substitution, not evidence that old address-spa=
ce
contents remain pinned.

Boundary test
-------------

A safe synthetic contract was run in disposable offline QEMU with a Linux
v7.2.4 KASAN/UBSAN kernel and a separate CONFIG_KSM=3Dy build.

The parent and target were separate processes with the same UID. The target
was explicitly dumpable before a synthetic root-owned setuid exec. The help=
er
then had euid 0, ruid 1000 and dumpable state 0. The parent had already ope=
ned
coredump_filter, clear_refs, KSM metadata and an environ control descriptor=
.
The parent wrote through the old coredump_filter and clear_refs descriptors=
,
then repeated the writes after the helper explicitly called
PR_SET_DUMPABLE(1).

The corrected matrix reported:

  same_uid_different_process=3D1
  target_dumpable_before_exec=3D1
  old_environ_not_current_mm=3D1
  helper_current_environ_new_mm=3D1
  helper_dumpable_after_setuid=3D1
  helper_dumpable_after_pr_set_dumpable=3D1
  old_fd_write_after_dumpability_transition=3D1
  control_mm_access_environ=3D1
  ksm_current_mm_mergeable=3D1
  proc-mm-boundary-matrix: PASS
  trigger_rc=3D0
  qemu_rc=3D0

The corrected boundary log SHA-256 is:

  164c9be37a3313f62e5abc587853ca9e83d3833a3eb4587a3f5b2bbd4a05cb92

The log contained zero KASAN, UBSAN, BUG, Oops, panic, WARNING, refcount or
Call Trace markers. This is expected to be a selection/consistency contract=
;
it is not a memory-safety crash test.

Impact and limitations
----------------------

The test demonstrates an implementation-level old-authorization/current-MM
selection gap for same-UID, initially dumpable processes across a synthetic
setuid exec. The demonstrated effects are limited to:

  - current-MM coredump-filter policy metadata;
  - current-MM soft-dirty/RSS accounting metadata; and
  - current-MM KSM metadata/mergeability observation.

The test did not establish:

  - cross-user unauthorized access;
  - protected memory or file disclosure;
  - a core dump acquisition or dumpability bypass;
  - credential or capability transfer;
  - a privileged file access;
  - a namespace transition or escape;
  - checkpoint bypass;
  - KSM page-content disclosure;
  - UAF, memory corruption, code execution, LPE or availability impact.

The target and helper were synthetic and ran only in a disposable initramfs=
.
No production privileged daemon or protected-data consumer was identified.
The result is consequently a conditional procfs authorization-consistency /
hardening candidate, and may be intended current-state behavior depending o=
n
the procfs ABI contract.

Fix question
------------

A possible hardening direction would be to couple permission revalidation,
current task/MM selection and the operation to one read-side
exec_update_lock epoch. However, I have not prepared or compiled a patch.

In particular, clear_refs can sleep, take mmap_write_lock_killable() and in=
voke
MMU-notifier callbacks; KSM counters remain asynchronous even with epoch-co=
upled
selection; and the lock ordering needs a lockdep-enabled build. The tested
CONFIG_KSM=3Dy image had CONFIG_PROVE_LOCKING and CONFIG_DEBUG_LOCK_ALLOC u=
nset,
so no runtime lockdep claim is made.

Questions for maintainers
-------------------------

1. Are coredump_filter and clear_refs intentionally allowed to operate on t=
he
   current post-exec MM through an already-open descriptor, or should their
   read/write-time target selection be coupled to the authorization epoch?

2. Should the KSM readers use the same epoch-consistent selection rule, or =
are
   their metadata-only snapshots intentionally current-state views?

3. Is the observed behavior best tracked as a follow-up to the public procf=
s
   exec_update_lock work, or as a regular procfs consistency/hardening issu=
e?

4. If hardening is appropriate, what locking/reference shape is preferred f=
or
   clear_refs given its mmap/MMU-notifier/TLB operation?

I have not attached the source-only harness or full console log to this ini=
tial
message. The minimal synthetic reproducer, consumer trace and complete evid=
ence
can be provided to maintainers on request. No exploit chain, race amplifier=
,
credential abuse, namespace operation or LPE work was performed.

Regards,
Nguy=E1=BB=85n V=C4=83n Ti=E1=BA=BFn
