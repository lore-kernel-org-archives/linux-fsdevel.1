Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793055198;
	b=Vn3R+qGrnjlRpK9HnR1/0TeatbH16KUXygnjMqWPh80V94LhohUKSezP3bPOwcWgMqRf
	 IqNM4x27sP07aDu8E4YTB28zDfSA/43MO670EwPwd+hINU48HTATEowsKBVFfxCYANEIO
	 EYrKjtPMlXGc5bAbEJF+5BRDZ526aVSuJN8ne6o1sYj7gNygKNOPchGGeB5I4kJKI0m/y
	 nRVzI6dlPrTG1unfHwRlVquzF6zM4N3hkT5ligIa0PKqA27OszcCtVrJ7WT9QrfB/QX9g
	 PykHoBMeQeLVl7LO1tczVZax2IHQksGRW6jGdTZFa0J0+Ccyt4GSYR1XBzaVJS2aehw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xc94Wk/F2zc9MG5PDwOCp2nxjups6yhZ4lvLdR7DtE0=;
	b=VTpInbuEinHdPj0zi1ssWw1C0kD8p6QC4Fayr0dF9+opZ9d6YWzrw2aRJMZo8ZYFrQQq
	 3oLxv5Zxfw+Ial2V/VqvdPsdTjLlbyA0rcO1AMCl9BUQ3gT50pVEQFfyludAtjngkobvY
	 9Nm3DkRg7qSCAOmXTuC8Eh1FpWjc1YYCpd/2XwMS1FKVsvoULqX975ctsoJlgKulVBYRH
	 IEwqqZ8VT0I5CYJ8eJjerj8Hvz+L8/8rKyGjRbUmpETt1vRiTPt0netSQlgkBa29sI8kv
	 nHShp0X6VtaRep/2WUqvpuxOROmui5zuFixMjbyrDcSTn0itgDomP4oNJsT+v9XsuYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GcRoHniT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BA606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 22:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE6BA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GcRoHniT
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40e30c26a4so60364966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 15:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793055196; cv=none;
        d=google.com; s=arc-20260327;
        b=X/BCFrQMqoOy/KM0unT3w+LwaABCqUprte3r/WwG4nTe5+pHHFJChNaQ2F1ILjyPzJ
         E1O4qsTNtYKGybd1Z6FDngkRTfH+iZi0R1ERkuHrJqmSTCrR5LloSdULMPvF5tn9wxvZ
         PE75VWc93YqGYQRGjkDxSXJElbOpX31XaYeFBUomigjUFMRP+WtGrd9sVw0rZAydJ6IF
         KYAzrxDC369Vq2+o3HEZ4JjSdr4EVY2zhFyYSmxmChZ/tppZKRLlKmR5C34UrYDBkgnx
         srPxX5XF0YaVUoHgYva2jyRzjHV15/y79CSHEUhLJR0mu1wcAa2RDZeJBlHgKsJjEtQx
         1Chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xc94Wk/F2zc9MG5PDwOCp2nxjups6yhZ4lvLdR7DtE0=;
        fh=Flk3+nujpyJpDZg5fX+SKT56B5vOkqn36QKGLe3a5qU=;
        b=L1KrTFmvtis7wCArbwETl9h768B/o6Wpk3RkvCkr7I7varjqhWv60loIfN09Iw/Pxt
         Ak/TVt2HFKDREo9VrZqI735wtfWWIKp6qG9v5NwG4WVZ+TtE6C2bSgp+TjjvebVTVNqu
         QKKbUlFQs4GtdQjQRbOHu+eIsPTjfoPP2EooGL9AH+Pq3QySRot2Tbv1FsbO4Xd48J6F
         iLCeJknuD+cx+q9MmMuWjGhX7ZAHzvjAFSVNTK6JDpnEEkZjTyrzf+cRWjngNcj7JznB
         DxzpztlLRZkB0PGglcUFvjixD0bIunWJTlr9NmXlO7eNE9B4UjKmfKfwYHqDb+dPk6j0
         HAeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793055196; x=1793659996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xc94Wk/F2zc9MG5PDwOCp2nxjups6yhZ4lvLdR7DtE0=;
        b=GcRoHniTbNvOEH+C4s5j7MliIXJgCsmUmyLLp5/aAWGwb+zd6gJOGEj14ZLhPmVKlH
         N3QURwIzI/+mQ7VARGFCrRneRc1FbeXCU5Vnh42ANGEDd3eQuaQNSiwXTaEwBsiVjQYu
         wuoI/QjidxD4JM5rvHrLwjGsHbxfQigIXcCW81v8ZLK9sfKmw9Yow5ocWH5xXzS6z5pH
         EEQ9qixqdbPwA4ryDeil0P7eI0Cnit9+b8/e7rb9Ia/Axb6JFkE8Lo/RilmdE87jSwyb
         BmUE52wcZU+B5CYiRTq/FtJzHs5L9ylp3l3EJzFafc/UBefejjx8d7ncN09pCnhHSyxo
         3TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055196; x=1793659996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xc94Wk/F2zc9MG5PDwOCp2nxjups6yhZ4lvLdR7DtE0=;
        b=Z3q/2cJHkvcALi2J51D95m+ql1zCYTTvlBK4JXdcb3ew+SPDJUkTAjt3+E2DZB4lIz
         kKrv0B4kv/mslvx9tDOFBb+U9wRhAVrjaMzMzTKhLM5qaULYnNXifyIqNSHxCqqfxIb3
         CxXrZt1jnBZ2vk8cQqBQMBTMtIlq3aUrlx6Y9uzSkMYMurfvLeXvcB+5hK6wCMOmPEJG
         fMuce9Djys/xfogPlzRzkpP8CK4DTpwGo7AbRdYPyftQ85hwfJwjTdbPo01RPWpnewhO
         b1lOibFNsxczcF3RoQsa8m7qPEFGfZmhPuMTvtpkmVXJp3R4W8djcOAWjcT4BP6xEur6
         H1+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxIPBv+qrkzYg5F4tw2GOHQSeDtknTwakJecjaLOGnWx/SKdHxYzswVlqxZ3JXOVl/++goat5JyIS8Sn/rK@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6afzVsKEyRh+cU3EGqepvvg4pc9/UW9Y5njSmKFlxz9DxFz3x
	J7mxiW92PGF5VO+xFhsjDuuGvq7Rl7uBzfJ4LtWy14ZIUAXrmNVsC+jVkXLHAxkXYxCAtezL3uO
	wKQ5pzNkyTsnftrXUo9Zw6qfV+2voLNI=
X-Gm-Gg: AYBFou05Zstutc8BTOjhGFo/FvIuNQu0FVK3OtTz7CkT7PegwMCmiYHaohTYSB6B5vE
	PH+u6vI/yT+B+wqg71xJwURftnZaR//JezZZjzXiaDZwFu1W5v7DLfBkparHsEF+f/1plin7+Fg
	HaBBoIjSIi/RORb347TiO5tsoONORVzW1qPnNRGTNDxxEREQlEYnhDw57sm8uUcSqyubZcd7VqY
	oVVhV12hWpa1RaGCoy0kbN+mTdLmdhS5IGv7lhMxMSa0vueF+4hIiOOq4wA7b5xyp3HEBOC2t+S
	av+rG0GRTjeItjOarYpcZRFHivPBTOwSf/I/ZF/dZLzCRDE3KY2iEpbwy3BG7wUXAW/UXT851jX
	6lXxxRdaMkY0Ao1xmcRAyu4kBK2uZmbVDq5gn7L4N1+VqpFsLHV58tZoL25/TUe5JeEouOWo=
X-Received: by 2002:a17:907:97c4:b0:c42:4557:452c with SMTP id
 a640c23a62f3a-c49a735c4e0mr77533566b.8.1793055195801; Mon, 26 Oct 2026
 15:53:15 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <P4sl5iz--F-9@tuta.io>
In-Reply-To: <P4sl5iz--F-9@tuta.io>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Oct 2026 00:53:04 +0200
X-Gm-Features: AclHuK_8tPDOgqDAee5bt5n8R6uq571-4nl8QMLSHK5TtZ4EQFbG5UF_c40Zhdg
Message-ID: <CAOQ4uxivnotjPOk8-6g2GMX2KdYXa06G2oiXRj=V9bR3NSnFhg@mail.gmail.com>
Subject: Re: [PATCH] backing-file: inherit FMODE_NONOTIFY from the user file
To: Edvard Conrad <edvard@tuta.io>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:12=E2=80=AFPM Edvard Conrad <edvard@tuta.io> wrot=
e:
>
> When fanotify reports a permission event, copy_event_to_user() creates
> the event fd with dentry_open_nonotify(), so that the listener's use of
> that fd does not generate further events. If the event's path is on a
> stacked filesystem, the stacked filesystem's ->open() opens the real
> file with backing_file_open(). Since commit ebe559609d78 ("fs: get rid
> of __FMODE_NONOTIFY kludge"), FMODE_NONOTIFY lives in f_mode only and
> the backing file does not inherit it: it is allocated with the default
> fsnotify mode, and fsnotify_open_perm_and_set_mode() raises FS_OPEN_PERM
> on the real path if the backing filesystem has permission event
> watchers.
>
> Before that commit __FMODE_NONOTIFY travelled in f_flags, and overlayfs
> copies the user file's f_flags into the backing open
> (ovl_open_realfile()), so the backing file was exempt implicitly. Commit
> bc2473c90fca ("ovl: enable fsnotify events on underlying real files")
> relied on that when it dropped FMODE_NONOTIFY from OVL_OPEN_FLAGS.
>
> The nested event is queued to the same group, from inside the
> listener's read(2), and can only be answered by another reader thread
> of that group. A listener holding filesystem marks on both the stacked
> and the backing filesystem therefore deadlocks as soon as all of its
> reader threads are inside such a read(2) at the same time, and every
> other task that touches a marked filesystem queues up behind it.
>
> Observed with a commercial anti-malware agent (16 reader threads) on an
> ostree/composefs host: / is an overlayfs whose data layer is the ostree
> object store on the same btrfs that holds /etc and /home, and a
> systemd-sysext overlay sits on /usr. Every on-demand scan of /usr wedged
> the whole machine until the group was killed. Stack of a blocked reader
> thread on 7.2.7:
>
>   fanotify_get_response
>   fanotify_handle_event
>   send_to_group
>   fsnotify
>   __fsnotify_parent
>   do_dentry_open
>   vfs_open
>   backing_file_open
>   ovl_open_realfile [overlay]
>   ovl_open [overlay]
>   do_dentry_open
>   vfs_open
>   backing_file_open
>   ovl_open_realfile [overlay]
>   ovl_open [overlay]
>   do_dentry_open
>   vfs_open
>   dentry_open_nonotify
>   copy_event_to_user
>   fanotify_read
>   vfs_read
>   ksys_read

Thanks for the report!

>
> Userspace cannot avoid this: the backing open happens while the kernel
> builds the fd, before the event is reported, and fid reporting is not
> available for permission event classes.
>
> Make a backing file inherit FMODE_NONOTIFY when the user file it is
> opened for must not generate events. This restores the pre-6.14
> behaviour for the fds that fanotify creates (and for any other
> FMODE_NONOTIFY file), while ordinary opens through a stacked filesystem
> keep generating events on the real path, as intended by bc2473c90fca.
>
> Verified with a self-contained reproducer (private tmpfs lower layers, an
> overlayfs over them, FAN_OPEN_PERM filesystem marks on the overlay and on
> one lower layer, a child opening a file through the overlay) in a qemu
> VM on this tree built with defconfig plus OVERLAY_FS, FANOTIFY and
> FANOTIFY_ACCESS_PERMISSIONS: without this patch the listener's read(2)
> never returns and the child's open is released only by the listener's
> death; with it read(2) returns, the event is answered and the open
> completes.
>
> backing_tmpfile_open() is left alone: its only caller is
> ovl_create_tmpfile(), whose user file is a regular overlayfs file.
>
> Fixes: ebe559609d78 ("fs: get rid of __FMODE_NONOTIFY kludge")
> Cc: stable@vger.kernel.org
>
> Assisted-by: LLM
> Signed-off-by: Edvard Conrad <edvard@tuta.io>
> ---
> Reproducer: nested-perm-repro.c (inline below). It unshares a mount
> namespace, mounts two private tmpfs and an overlayfs over them, puts
> FAN_OPEN_PERM filesystem marks on the overlay and on one tmpfs, and lets
> a child open a file through the overlay. On an unpatched 6.14+ kernel
> the listener's read(2) never returns (the kernel raises a second
> permission event for the backing file while creating the event fd); with
> this patch it returns and the child's open completes. Verified in a qemu
> VM on a defconfig+overlayfs+fanotify build of this tree, before and
> after the patch (x86_64 defconfig plus OVERLAY_FS, FANOTIFY and
> FANOTIFY_ACCESS_PERMISSIONS). Also observed in production: Bitdefender
> BEST with filesystem marks on the btrfs that holds the ostree object
> store and on a systemd-sysext overlay over /usr, Fedora kernel 7.2.7, on
> a bootc/composefs host; every scan of /usr wedged the machine until the
> group was killed. Full SysRq-w dumps available on request.
>
> Tool disclosure (Documentation/process/generated-content.rst): the stack
> analysis, the git-history search for the regressing commit, the patch
> text, the commit message and the reproducer were produced with an AI
> coding assistant (Anthropic Claude Code) under my direction over
> interactive sessions; I reviewed, built and tested the result. No static
> analysis tools beyond checkpatch were used.
>
> nested-perm-repro.c:
>
> /*
>  * nested-perm-repro.c =E2=80=94 fanotify permission event raised by the =
kernel's own
>  * event-fd creation on a stacked filesystem (overlayfs), deadlocking a l=
istener
>  * with a single reader thread. Self-contained: builds a private tmpfs + =
overlay
>  * stack inside a new mount namespace, touches nothing else on the system=
.
>  *
>  *   gcc -O2 -Wall -o nested-perm-repro nested-perm-repro.c
>  *   sudo ./nested-perm-repro
>  *
>  * What it does:
>  *   1. unshare(CLONE_NEWNS); mount tmpfs A and tmpfs B; create A/file;
>  *      mount overlay M with lowerdir=3DA:B (read-only overlay, no upper =
needed).
>  *   2. fanotify group (FAN_CLASS_CONTENT) with FAN_OPEN_PERM *filesystem=
* marks
>  *      on M (the stacked fs) and on A (the backing fs) =E2=80=94 the sha=
pe of an
>  *      anti-malware agent watching both the OS tree and the disk it live=
s on.
>  *      Filesystem marks, not mount marks: overlayfs opens its layers thr=
ough
>  *      private clones of the lower mounts, which a mount mark never matc=
hes.
>  *      Each tmpfs is its own superblock, so the marks touch nothing else=
.
>  *   3. fork: the child opens M/file. That raises an OPEN_PERM event on M=
.
>  *   4. The parent read()s the event. The kernel builds the event fd with
>  *      dentry_open_nonotify() -> ovl_open() -> backing_file_open() on A/=
file.
>  *      On kernels >=3D 6.14 without the fix, that inner open raises a SE=
COND
>  *      OPEN_PERM event on A, queued to the same group, from inside read(=
2).
>  *      With one reader thread nobody can read it: read() never returns.
>  *   5. The parent dies on alarm(TIMEOUT) (SIGALRM, default action; the s=
leep is
>  *      TASK_KILLABLE so the fatal signal gets through). Closing the grou=
p
>  *      answers everything FAN_ALLOW; the child's open completes and repo=
rts
>  *      how long it was blocked: >=3D TIMEOUT means REPRODUCED.
>  *
>  * Expected output on an affected kernel:
>  *   parent: read() on the fanotify fd ...
>  *   child : open took 3.0 s (unblocked only by the listener's death) -> =
BUG REPRODUCED
>  * On a fixed kernel the read returns at once, the parent answers FAN_ALL=
OW,
>  * and the child reports a few milliseconds -> not reproduced.
>  */
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <sched.h>
> #include <signal.h>
> #include <time.h>
> #include <sys/mount.h>
> #include <sys/stat.h>
> #include <sys/wait.h>
> #include <sys/fanotify.h>
>
> #define TIMEOUT 3
> #define BASE "/tmp/nested-perm-repro"
>
> static void die(const char *what)
> {
>     fprintf(stderr, "%s: %s\n", what, strerror(errno));
>     exit(1);
> }
>
> static double now(void)
> {
>     struct timespec ts;
>     clock_gettime(CLOCK_MONOTONIC, &ts);
>     return ts.tv_sec + ts.tv_nsec / 1e9;
> }
>
> int main(void)
> {
>     char a[128], b[128], m[128], file[160], opts[512];
>     int fan, fd;
>     pid_t child;
>
>     snprintf(a, sizeof a, "%s/A", BASE);
>     snprintf(b, sizeof b, "%s/B", BASE);
>     snprintf(m, sizeof m, "%s/M", BASE);
>     snprintf(file, sizeof file, "%s/file", m);
>
>     /* 1. private mount namespace + the stack */
>     if (unshare(CLONE_NEWNS) < 0) die("unshare(CLONE_NEWNS)");
>     if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) < 0) die("make-=
rprivate /");
>     mkdir(BASE, 0755);
>     mkdir(a, 0755); mkdir(b, 0755); mkdir(m, 0755);
>     if (mount("tmpfs", a, "tmpfs", 0, "size=3D1m") < 0) die("mount tmpfs =
A");
>     if (mount("tmpfs", b, "tmpfs", 0, "size=3D1m") < 0) die("mount tmpfs =
B");
>     {
>         char p[160];
>         snprintf(p, sizeof p, "%s/file", a);
>         fd =3D open(p, O_WRONLY | O_CREAT, 0644);
>         if (fd < 0) die("create A/file");
>         (void)!write(fd, "hello\n", 6);
>         close(fd);
>     }
>     snprintf(opts, sizeof opts, "lowerdir=3D%s:%s", a, b);
>     if (mount("overlay", m, "overlay", 0, opts) < 0) die("mount overlay M=
");
>     printf("stack : %s =3D overlay(lowerdir=3DA:B), A and B are private t=
mpfs\n", m);
>
>     /* 2. the listener: one group, permission marks on the stacked AND th=
e backing mount */
>     fan =3D fanotify_init(FAN_CLASS_CONTENT | FAN_CLOEXEC, O_RDONLY | O_C=
LOEXEC);
>     if (fan < 0) die("fanotify_init");
>     if (fanotify_mark(fan, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, FAN_OPEN_P=
ERM, AT_FDCWD, m) < 0)
>         die("fanotify_mark M");
>     if (fanotify_mark(fan, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, FAN_OPEN_P=
ERM, AT_FDCWD, a) < 0)
>         die("fanotify_mark A");
>     printf("marks : FAN_OPEN_PERM filesystem marks on M (stacked) and A (=
backing)\n");
>
>     /* 3. the victim */
>     child =3D fork();
>     if (child < 0) die("fork");
>     if (child =3D=3D 0) {
>         double t0, dt;
>         int rc;
>
>         close(fan);
>         usleep(200 * 1000);
>         t0 =3D now();
>         rc =3D open(file, O_RDONLY);
>         dt =3D now() - t0;
>         if (rc >=3D 0) close(rc);
>         if (dt >=3D TIMEOUT - 0.5)
>             printf("child : open took %.1f s (unblocked only by the liste=
ner's death) "
>                    "-> BUG REPRODUCED: the listener's read() never return=
ed\n", dt);
>         else
>             printf("child : open took %.3f s (rc=3D%d) -> not reproduced\=
n", dt, rc);
>         _exit(0);
>     }
>
>     /* 4. one read(). On an affected kernel this never returns. */
>     printf("parent: read() on the fanotify fd (dies on alarm after %d s i=
f it hangs) ...\n",
>            TIMEOUT);
>     fflush(stdout);
>     alarm(TIMEOUT);
>     {
>         char buf[4096];
>         ssize_t n =3D read(fan, buf, sizeof buf);
>         struct fanotify_event_metadata *md =3D (struct fanotify_event_met=
adata *)buf;
>         struct fanotify_response resp;
>
>         alarm(0);
>         if (n <=3D 0) die("read");
>         printf("parent: got event mask=3D%#llx fd=3D%d pid=3D%d =E2=80=94=
 read() returned, answering ALLOW\n",
>                (unsigned long long)md->mask, md->fd, md->pid);
>         resp.fd =3D md->fd;
>         resp.response =3D FAN_ALLOW;
>         (void)!write(fan, &resp, sizeof resp);
>         if (md->fd >=3D 0) close(md->fd);
>     }
>     close(fan);
>     waitpid(child, NULL, 0);
>     return 0;
> }
>

Any chance you can post this as an LTP test?

>  fs/backing-file.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 5614cb7801e..24357bf9328 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -43,6 +43,17 @@ struct file *backing_file_open(const struct file *user=
_file, int flags,
>         if (IS_ERR(f))
>                 return f;
>
> +       /*
> +        * A user file that must not generate fsnotify events (e.g. the f=
d
> +        * that fanotify creates for a permission event with
> +        * dentry_open_nonotify()) must not generate them through its bac=
king
> +        * file either. Otherwise a listener watching the backing filesys=
tem
> +        * gets a nested permission event from its own read(2), which onl=
y
> +        * another reader of the same group can answer.
> +        */
> +       if (FMODE_FSNOTIFY_NONE(user_file->f_mode))
> +               file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> +
>         path_get(user_path);
>         backing_file_set_user_path(f, user_path);
>         error =3D vfs_open(real_path, f);
> --
> 2.56.0
>

Urgh I hate how special case this is.

How about something like below (untested)

Thanks,
Amir.

diff --git a/fs/file_table.c b/fs/file_table.c
index e2665eaa6f8c2..ef79894e2da7a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -176,7 +176,8 @@ static int __init init_fs_stat_sysctls(void)
 fs_initcall(init_fs_stat_sysctls);
 #endif

-static int init_file(struct file *f, int flags, const struct cred *cred)
+static int init_file(struct file *f, int flags, const struct cred *cred,
+                    fmode_t fmode)
 {
        int error;

@@ -200,7 +201,7 @@ static int init_file(struct file *f, int flags,
const struct cred *cred)
        memset(&f->f_ra, 0, sizeof(f->f_ra));

        f->f_flags      =3D flags;
-       f->f_mode       =3D OPEN_FMODE(flags);
+       f->f_mode       =3D OPEN_FMODE(flags) | fmode;
        /*
         * Disable permission and pre-content events for all files by defau=
lt.
         * They may be enabled later by fsnotify_open_perm_and_set_mode().
@@ -263,7 +264,7 @@ struct file *alloc_empty_file(int flags, const
struct cred *cred)
        if (unlikely(!f))
                return ERR_PTR(-ENOMEM);

-       error =3D init_file(f, flags, cred);
+       error =3D init_file(f, flags, cred, 0);
        if (unlikely(error)) {
                kmem_cache_free(filp_cache, f);
                return ERR_PTR(error);
@@ -297,14 +298,12 @@ struct file *alloc_empty_file_noaccount(int
flags, const struct cred *cred)
        if (unlikely(!f))
                return ERR_PTR(-ENOMEM);

-       error =3D init_file(f, flags, cred);
+       error =3D init_file(f, flags, cred, FMODE_NOACCOUNT);
        if (unlikely(error)) {
                kmem_cache_free(filp_cache, f);
                return ERR_PTR(error);
        }

-       f->f_mode |=3D FMODE_NOACCOUNT;
-
        return f;
 }

@@ -316,6 +315,16 @@ static int init_backing_file(struct backing_file *ff,
        return security_backing_file_alloc(&ff->file, user_file);
 }

+/*
+ * A user file that must not generate fsnotify events (e.g. the fd
+ * that fanotify creates for a permission event with
+ * dentry_open_nonotify()) must not generate them through its backing
+ * file either. Otherwise a listener watching the backing filesystem
+ * gets a nested permission event from its own read(2), which only
+ * another reader of the same group can answer.
+ */
+#define BACKING_FILE_FMODE_MASK (FMODE_NONOTIFY)
+
 /*
  * Variant of alloc_empty_file() that allocates a backing_file container
  * and doesn't check and modify nr_files.
@@ -328,19 +337,19 @@ struct file *alloc_empty_backing_file(int flags,
const struct cred *cred,
 {
        struct backing_file *ff;
        int error;
+       fmode_t fmode =3D user_file->f_mode & BACKING_FILE_FMODE_MASK;

        ff =3D kmem_cache_alloc(bfilp_cache, GFP_KERNEL);
        if (unlikely(!ff))
                return ERR_PTR(-ENOMEM);

-       error =3D init_file(&ff->file, flags, cred);
+       error =3D init_file(&ff->file, flags, cred, fmode |
+                         FMODE_BACKING | FMODE_NOACCOUNT);
        if (unlikely(error)) {
                kmem_cache_free(bfilp_cache, ff);
                return ERR_PTR(error);
        }

-       /* The f_mode flags must be set before fput(). */
-       ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
        error =3D init_backing_file(ff, user_file);
        if (unlikely(error)) {
                fput(&ff->file);
