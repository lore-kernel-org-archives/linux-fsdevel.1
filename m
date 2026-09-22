Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D9382F08
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056952; cv=none; b=LiPRdJTaAsxifdiKapgyR3vThGc3aqK+RP5Ju4Lg3KmL5dYDIzAO4GBpOCsIjbrCrPs3MvZFGwCP/4UxF7qHk0XxA66/Ahbb0nxhj4ov+kpYQMhKMoJ5u3AjC0h2vX+KBZSAYz6Z0Mh07/H98Kgf1oSezbTC68v/W4/vYq/clvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056952; c=relaxed/simple;
	bh=/gkxxAEJ2VEsBzCj+0PCJrUAyaQRh7llGGlVQ5kUCrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNYkC+J2NbCOpGNathuEOCGYgY9qp80JQeRMU8qRreD/HFmscA0ne0bT33V+qu9CIRaeAEcpbEAsv/9GEeZ8i4fKBN/awXbAE5buiCHfZ1c+75ubigDs+yFkOxa8sv0dYDr9SozQ1CGSIi2eUBR61PV0DIPVHTbw5WRvsCKO6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1801fso3746003e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 23:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790056947; x=1790661747;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51dqkeK+6HTCaJdD0DRXH94PwuZHWhVc5MOITOLNdLE=;
        b=rf/vCSdJ1UFZ5nCng+ern3C6gxDR95yE6074wJj2CG25Yi7pU7YU5zRTpBcruzYDli
         B1Y49VY/5U/RrsNpfznU6ohPat7u7DrCyQri2PsJrcNO30q8ijdOSnmT/Sue4sQm6YHI
         81RFzQOCVjMn7nk4WMTtthsu4q4R29yWcX6SW0OGH06Hv1Mfmu/F7D71gC1bkkG/uNwS
         4tmaldy6c4U/DI/wTog/jDlRlfWU2iCaiSNTNYlB6xRuzr91MG8uPvxf0t++gbSfJlhI
         IJ+ZtyK2a5+pWC2fvqBgIJUFkX8U1+MU5i6NX+jun21VE18mSHRFU7Py9uhP/YZyTg+W
         S0TQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4KMICoF6gSHLKEFaEdrLWO9sOUgwVKqL9UV3tX+FK5hub09q1oeXCTaa+DyX0rYhqX3NRuePAaoLy+K02@vger.kernel.org
X-Gm-Message-State: AFuF++k0xMemtIslJpZGx1nmQVW9irialhEjlrrcvV/6GDnAzctQ2SOm
	M0vJIWfxK5qn6cVwyn5/mdSyZTnypRwGXdogd9xHvvTMn6IvelIeyntCPLARgWqZzIWYBQ==
X-Gm-Gg: AYBFou3xBdv2DbU2zJebIQ+MWWNoUgZdIbIdOxaMddciyGpoqNGVsbgFnp1RD1fgRRJ
	j/Ge6m3XZUEUfrDZpmlUpGAgHN7zr+ub5Y/TNrD5UizR5lWxk26A+ztHKOsOmBZZO1uJk0leBbX
	FzlLOZcsJ8ZpSyhjdGjKugQeL1rk5MJq6dsLL6jPV214DFKfOag6ctuCYtEkqVmf2BvXUEDEV03
	spsAvOQzhjdU1nUl60JKycq39jRW5yAlKWP1oUPlD09NDtvoVRYIBuiBI44tI0cW3SCNxydjc+T
	h6rl88Nl7KmV/qkKEXMj0NzzB7SitNmq2BfBgjbhw4t9WK12/hen6E5rKju/QA1fvLeXgtNZBQm
	nYOoLR4tYmvxD3uSAJtJn37dkUTILDsqDW2G7LFSsIg/5SJblnmoBfuBNzU/tMnhnVYLqWczT8c
	TaJO34qQoXPl7Id4aZ2EIkavI1DMTNT6F3UDKXP3kELqzYoJ2pdXvNWzI+XGO75EVAL2G1EtAKZ
	UnoGS88YNG6Mg+7mvhrf7R0uvoCYuvRsrXKgRbHHtjhwrudRt+CGQKdnnRDurIa
X-Received: by 2002:a05:6512:3e25:b0:5b8:d078:da8e with SMTP id 2adb3069b0e04-5b8d078e2c7mr1228633e87.28.1790056947321;
        Mon, 21 Sep 2026 23:02:27 -0700 (PDT)
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com. [74.125.229.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46d2072sm215807e87.17.2026.09.21.23.02.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 23:02:26 -0700 (PDT)
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1801fso3745976e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 23:02:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy6btwF1y9AQ9Sbxp+0bxN8t0Rz46PjDo41T0Gp6StdKXfNXZgJLVU8nkuFU26BETuHfsYIVNQeL4REYuvK@vger.kernel.org
X-Received: by 2002:a05:6512:110a:b0:5b8:99a5:5162 with SMTP id
 2adb3069b0e04-5b8c180e6cfmr3759117e87.26.1790056945794; Mon, 21 Sep 2026
 23:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn>
 <20260831-tauwetter-werkbank-dramen-b37eb4025283@brauner> <CAC1kPDMK_D4nhyRmBHg6KC7SmmCkH73Xtc5DhXeJbSvf3LcqcQ@mail.gmail.com>
 <CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZCW0iENJvasKfg@mail.gmail.com>
In-Reply-To: <CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZCW0iENJvasKfg@mail.gmail.com>
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 22 Sep 2026 14:02:14 +0800
X-Gmail-Original-Message-ID: <CAC1kPDNamG4BpfsX0mn9E-Y+ujGTLe-oU63kJFOjxW6bDmSLnQ@mail.gmail.com>
X-Gm-Features: AclHuK8ITwQn4waky8resdLcCFExt5UoOF-9n53imPe55RkN7kQMS7sWnKkQWLA
Message-ID: <CAC1kPDNamG4BpfsX0mn9E-Y+ujGTLe-oU63kJFOjxW6bDmSLnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Jann Horn <jannh@google.com>
Cc: Chen Linxuan <me@black-desk.cn>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:22=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Sep 2, 2026 at 8:47=E2=80=AFAM Chen Linxuan <me@black-desk.cn> wr=
ote:
> > On Mon, Aug 31, 2026 at 4:49=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On 2026-08-31 10:59 +0800, Chen Linxuan wrote:
> > > > Obtaining a target task's executable, working directory, or root
> > > > currently requires walking procfs symlinks such as /proc/<pid>/exe,
> > > > /proc/<pid>/cwd, and /proc/<pid>/root.  That makes the operation de=
pend
> > > > on procfs being mounted and visible to the caller, even when it alr=
eady
> > > > holds a pidfd for the target.
> > > >
> > > > This series adds PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT. =
Each
> > > > ioctl takes no argument and returns a close-on-exec O_PATH file
> > > > descriptor referencing the corresponding task path.  The new ioctls=
 use
> > > > the same ptrace permission check and nonzero-argument rejection as =
the
> > > > existing pidfd namespace ioctls.
> > > >
> > > > The target task is sampled while holding its exec_update_lock. This
> > > > keeps the access decision and the task-state read in the same exec
> > > > critical section, preventing a concurrent execve() from changing th=
e
> > > > credentials or target state between the check and the use.
> > > >
> > > > The first patch factors out helpers for acquiring referenced task p=
aths
> > > > and reuses them in procfs and AppArmor.  The second patch introduce=
s
> > > > scoped cleanup for privileged pidfd task access and separates names=
pace
> > > > lookup from namespace fd creation.  The final patch uses these piec=
es to
> > > > implement the three new ioctls.
> > > >
> > > > Signed-off-by: Chen Linxuan <me@black-desk.cn>
> > > > ---
> > >
> > > I really have difficulties forming an opinion on this. So this sounds
> > > very useful but it has implications.
> > >
> > > Right now, pidfd ioctls are available even in situations where the ta=
sk
> > > in question would not be accessible via procfs, e.g., when procfs is
> > > mounted with "hidepid" options or similar. So this would expand the
> >
> > One point regarding hidepid: for callers that can pass
> > PTRACE_MODE_READ_FSCREDS, hidepid does not provide an additional
> > restriction. With hidepid=3D1 or hidepid=3D2, has_pid_permissions() fal=
ls
> > back to ptrace_may_access(..., PTRACE_MODE_READ_FSCREDS), and
> > hidepid=3Dptraceable uses that check directly. In addition, the
> > /proc/<pid>/{exe,cwd,root} links independently perform the same
> > PTRACE_MODE_READ_FSCREDS check in call_proc_get_link(), regardless of
> > the hidepid mode.
> >
> > So for these specific path lookups, hidepid does not block a caller who
> > would already pass the check used by the proposed pidfd ioctls.
>
> Agreed, I think with regards to hidepid there should be no issue here.
>
> If I try to come up with scenarios in which this could introduce
> additional danger, the main one I can think of would be: A task T1 is
> running inside a pid namespace and has a unix domain socket connection
> to a task T2 outside the namespace, with both running as the same
> EUID; T1 sets SO_PASSPIDFD on its socket to obtain a pidfd pointing to

Does SO_PEERPIDFD matter too?

> T2 on the next message sent by T2, then T1 uses that to get access to
> the mount namespace of T2.
>
> Christian, is there some mechanism that already protects against using
> something like SO_PASSPIDFD to get a pidfd to a process in a parent
> namespace?
> Otherwise, should we add something like a "pid_vnr(pid) !=3D 0" check
> either in these new operations or in SO_PASSPIDFD?
>
