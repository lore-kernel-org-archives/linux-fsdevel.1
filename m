Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A892AE78
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784349840; cv=pass; b=oqfnP2w6cU8CyUV9jkKYJnxlCExc0JyPhSEaTvTe+qBJ/GyUGc/+FZaVul3O14vyUnsgbu1eiM2L5eo5B5nUZms8+90p6Mn2fveKyI2F0nRnH1lzYJLIYOG6osMd4EQgaoRmEkXgw/jtfq9S5yJhFYuLjr/hs56u6xLjcdZgkgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784349840; c=relaxed/simple;
	bh=r3gWmr7KxT+R8fRLEF0oFD62qW+J+bcDbN32u9bfR/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jAyvoY7xVfX2Hm5vYIvMQGKNAKkpmDOeDFmtBTcr2ujdaWfVKW7BEpMjIOb2Ws21OdzNLP1MLkLm+aY6fOlM7Fk37Ug4SYL5fflJhpI6OK71Ib+ca4F4UNM7alGD5K9AwTso5uvJSzo6FHZ7QaSOFtit3rmaA5HI9bzLRQV/kao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lx45T9bz; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lx45T9bz"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c16ac21acso34772871cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 21:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784349838; cv=none;
        d=google.com; s=arc-20260327;
        b=hz0wAkxymenDNivCzGrM0RRwPliCXuNxnP2+q/LdpCSIR+15fZLG3VSanmLbXxgvuP
         XICCkragFtsxJMPARTUlobKHXCqqVWIAdk/ThpIA5XbC8huqPjNzMt4jZSkkBZCwxUlk
         /4ODPs1qaf4SwatO4Xmaj6itanidtp1vQ7haj4KX7LW31edkiauAoZtdh8Ftw52kw0QF
         bfBC2pl6SnIgjRHmu3C10A8OCHxfAzT/wiKB3pHfrZ5smxPrqFLhvpfrsBZh7cPKmRkm
         VrT5GYMJx5glsfG82vWMNCBZvrnzUfDd97XXhE5nSApT7SKpFcLARWTXeEGRwrkffXH0
         qE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kqghXG71jJkfg0+hlE1v7q+hJ20WxlU8IXS1ofw4PSc=;
        fh=tAyDp0kEYg4RlU9h9XMsz+QIDjLxyJw62KxJwbaIwrw=;
        b=FbXPeVFNSfoGV0o7QIqCRoimMKY0paiuDQ1TRYMnpjUF/dx894Loz92yLVXhdct/37
         rbdt3EgZDrHMabNhFHY807+B/KlKDY80n2DTPlhp8aOMu8oyCBxPL3FXqTJZ/s3ZXshw
         70jPS86I0GtA0Pa3ZOKUKi+MNeBgkMUfEplgNEEX8wVQYlqA7kUG4+vW3fiYQ06cmpfL
         uxHy2NNjGTGR65tZXEQn9Z4+rPrRU8DUm+GwoNyjPGrixmXYhblCwVkP5sMUy+MMYNr+
         V6J+xPmPr4sxPDJHtuyvGS1xEOTogybvotcYrc45Yy36BqYIRQoygR2rS6Y0w/wt4+zP
         5rWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784349838; x=1784954638; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kqghXG71jJkfg0+hlE1v7q+hJ20WxlU8IXS1ofw4PSc=;
        b=Lx45T9bzthUoYSDeBlVSBP2WzRqB2L3ysxi1RuP2bYhPAhUb6DZ6X0f9bk+rBCgXFV
         +OY/dy9yJXAJbppmwhXshosLuUvPbEjC3D9bjizsUV24cGvH1tL6HFU8y7O6/d+UHn0O
         pcOi8lLFY4GtjORHd/itvK44qQ0T96nQ6okXwhGcC4Xk5DoGHhciNZdDMRZWZcbBHp/W
         QX4vnan6Agjf3QOA9kNB5wFBiTmqwdTeyz24OzcHvsUbiVEQGePpEr/JmtfrLdrunsnh
         r6vIFJbUQpghAg33MYfXajdTKFX8+5vwAroqWHrT8nhb5UE7d8RXjZvrKW2lvxh8mA0r
         XaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784349838; x=1784954638;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kqghXG71jJkfg0+hlE1v7q+hJ20WxlU8IXS1ofw4PSc=;
        b=KVsqswwm7x4l2celEo0O3NaRXgm9+ecAuPacsF27NNEKegXH574+oUxQW+xZ+dAkFU
         XkZkqKjIrF03ugSm16YHITnQyC8/yHWP6WvCSU+11Okl5FGo6x6yUToqnep69kRCts55
         PaX++QoDvZ8FzolZHuxoGovb6dZr9RVqEnqvUrVCv8mSL/9bf5SQEpwi4F+rwrZhTLLl
         ll+O7FW7Cbuo4ez0BqDIuU8XRoG0IIOVZPsfcrrzhxbcnxJ3Nl7vPh04lGv1Q081S7nn
         Aq/uuuxplJZbLe3mki8kWFx9NrzZ3sIrC3kBcXGdljJT8s7ajNvvmCAr4xeJz77JmsOX
         yUqg==
X-Gm-Message-State: AOJu0YzLMc9D7RwRQTZzCVrRoo9VSLfIH62uXHbsTSQK4xMoNUh20Y1x
	Y7VtzNYmdqfpmtIxaHjthLxPH+zIDcR1ziqKAXS+0z8TKKn5ckaG+C4NtN9/vX1PwIG4YePr9Bc
	Sg+7MkphhGvHyY/v2XZzobPAUZMYwLlg=
X-Gm-Gg: AfdE7ckxpEgGqwo6sEOS9If7ZLllkwPaZv61DBI9BItGbyvwFaCdD5FKrHxSuhxuLEA
	RZTZX0vZUqXhMcmA74cBb/oLzOYAC80pktBUBRLA/l14zpDa4zfyEmTZWR3um9TOi1hFFOIMyB4
	6EKdbGE1IYXl9L04VoNiOKQrFEYxpWi+5UDhQS0DoT9RXwpU3n8vbXDLEhKsQjb3eyA4shy6kWy
	NXYiDsDv0P64XNmA10ECFQDOvUEff978pMfga9Y45mcV+QaRXcroH9bH7gHfeFwuH+3n50TErdC
	jXPJ6XQ9sDJvnKFXO9lP3X5aHFnuFc8=
X-Received: by 2002:a05:622a:1a85:b0:517:146d:2db5 with SMTP id
 d75a77b69052e-5213c10a295mr52923981cf.2.1784349837586; Fri, 17 Jul 2026
 21:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vivek Parikh <viv0411.parikh@gmail.com>
Date: Sat, 18 Jul 2026 10:13:46 +0530
X-Gm-Features: AUfX_mw8-MnFampnYBFO8G4t5y3dgEtdV6rgTCEQLCJdGrYM6EEg27_ZPbDNoDg
Message-ID: <CAHKnOm098q+3rjU9Ybo9vJYOW1K0h+A1hPFt8nw+6bEmcwywSA@mail.gmail.com>
Subject: [REPORT] binfmt_misc: leaked write-access denial on F-flag
 interpreter inode
To: viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Note: this bug was found with AI assistance, so I am treating it as public
per Documentation/process/security-bugs. A reproducer (unprivileged C PoC)
is available on request; I am not posting it here.

Summary
-------
put_binfmt_handler() closes an F-flag (MISC_FMT_OPEN_FILE) entry's
interpreter file without restoring the write access that open_exec()
denied at registration. Every register/delete cycle of an F entry leaks
one i_writecount denial on the interpreter's inode, so that inode returns
-ETXTBSY to all writers until it is evicted from the inode cache or the
machine reboots.

Affected versions
-----------------
Introduced in v4.7 by commit 948b701a607f. Present through v7.2.0-rc3
(fs/binfmt_misc.c:162-168). Root-only from v4.7; reachable by an
unprivileged user from v6.7 onward, when binfmt_misc gained
FS_USERNS_MOUNT and can be mounted inside a user namespace with no
capability check on registration (on systems that permit unprivileged
user namespaces).

Details
-------
Registration of an F entry opens the interpreter via open_exec()
(fs/binfmt_misc.c:821), which calls exe_file_deny_write_access() in
do_open_execat() (fs/exec.c:800). do_open_execat() documents that the
caller must call exe_file_allow_write_access() before releasing the file.

The registration error path honors this (fs/binfmt_misc.c:834):

        exe_file_allow_write_access(f);
        filp_close(f, NULL);

The teardown path does not (fs/binfmt_misc.c:162-168):

        static void put_binfmt_handler(Node *e)
        {
                if (refcount_dec_and_test(&e->users)) {
                        if (e->flags & MISC_FMT_OPEN_FILE)
                                filp_close(e->interp_file, NULL);
                        kfree(e);
                }
        }

filp_close()/fput() do not reverse the deny count, so the denial is
leaked. This is the persistent file opened by open_exec() at
registration; it is distinct from the per-exec clone made in
load_misc_binary() (fs/binfmt_misc.c:251-254), which is released
elsewhere.

Reproduction (conditions)
-------------------------
- CONFIG_BINFMT_MISC enabled.
- For the unprivileged case: kernel/distro permitting unprivileged user
  namespaces (v6.7+ for the userns-mount path).
- Steps: mount binfmt_misc; register ":x:E::x::<victim>:F" for any
  world-readable regular file on a non-noexec mount; delete the entry
  ("echo -1"); open(victim, O_WRONLY) then fails with -ETXTBSY.
The victim needs no execute bit; open_exec only requires a regular file
on a non-noexec mount.

Verified: unprivileged (uid 1000) on a 7.0.0-27-generic host, and as
root on a 7.2.0-rc3 build.

Fix
---
Mirror the registration error-path fix on the teardown path.
exe_file_allow_write_access() is NULL-safe and skips the same
FMODE_FSNOTIFY_HSM files that exe_file_deny_write_access() skipped, so
no imbalance is possible.

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -162,8 +162,10 @@ static void put_binfmt_handler(Node *e)
 static void put_binfmt_handler(Node *e)
 {
  if (refcount_dec_and_test(&e->users)) {
- if (e->flags & MISC_FMT_OPEN_FILE)
+ if (e->flags & MISC_FMT_OPEN_FILE) {
+ exe_file_allow_write_access(e->interp_file);
  filp_close(e->interp_file, NULL);
+ }
  kfree(e);
  }
 }

Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary
handler for containers")
Signed-off-by: Vivek Parikh <viv0411.parikh@gmail.com>
