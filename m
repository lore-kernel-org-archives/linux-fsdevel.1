Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDE427A1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323753; cv=pass; b=ZjOq5nwP7IBryTZIMI9Kj7LAXa/UuP3ycDgi4jawqEpxQOmmFn1RhE4rXap9AX+5djfJLkwMwMTWLyLofUqaiVkBL5q9yaDO79G+WIzR72Q9xgEaVODwgcRp0aZJWAZXgrs9I8Sepj5xbMuwOZza6JPVfOOicYhqLQNbAlW6v/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323753; c=relaxed/simple;
	bh=e7lZBlf4BQjKWZ7FXBRUvZEHvETpn0y3fvgbNkdPxwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4bqTBTvPLl1Is8MJ/xQeuTGChNjQow/yIU714zDnQklfqtSqegGrom/ckwIsIWC02Q470g/0ln3VF0/CnY/R13PQvzjWVXuSjlwFBEJYYKGXKMHiuiW3P7KSFnF6cJ0w6/a86sN6NymBYRlsfgwLFy+dE4vG/SwuwRs8C42D8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfjl0MYN; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfjl0MYN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cede6375caso101095ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 07:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787323751; cv=none;
        d=google.com; s=arc-20260327;
        b=Lmy/dw4qcCMHPpddixmN+y7QVaN/IcTSd5yVXTVUqwXMAsMU+x7TeY0U1iol2wSWBy
         VPq8oXmMltCILCgHTcxU36C8fbsvZgeKdaTq/sGXkWnKZBUwoz82+NnfDt9W56DjGoNj
         lpakhcfK0fE+ntanIZJg1+Ci+mdDfMUDsaGWnXlrGHKKEeJ8Yr/JM36zdVes7YBm+It5
         P6tMFcKweGSlUGn0C1FjdDUstu+qWbYMd/dMBL/JS08kQL3+hUndP7XgCvPUXNkTLTo1
         5zQw1KPzxPvre9B7CNUsW7RmtA/WTzLPiukUY+Rs7dnwL07MilX1o6JU0Gn5/O9+r00l
         9XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vlc/iU0BEBi/KNin4z6a2IXssoOeWKNQCCK9ZmekGRI=;
        fh=5Msd8CwCsjVb0gmHid7zYufeZlFZkvHpg41bjUz7Y0k=;
        b=O2/VxmE7EDKjj2c1ZELqSui24ij9kk/z7g3iqYmESrgNt1VMelWQ/Yr/Bn1FCEZwqT
         imG54pmfPTnys9PnHGuFHNyOm2o3EmE6vzO8Xe8PvtFkHlqBROd6gcjYjjbkZpkaGquR
         t+5t4mTpKXyZi4rf4WZdam7VTP2yt0z/O8WewZKQfd89NV95V/88SMrNlDqW40oePvo1
         B0wXHptKr6WNyCa/wc9mxyEZFg4IOo6W8jYQGJQFxEjKbPS9CaAAImJSiEBdhOuEt+dQ
         wmRh67tzhVLuDgYMa9OV3mOeUNY8CuDUSz46lsLMHsNGV+yij/ptOtGFEJ/64k4yRtkm
         TGqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787323751; x=1787928551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vlc/iU0BEBi/KNin4z6a2IXssoOeWKNQCCK9ZmekGRI=;
        b=nfjl0MYNhwStfkYy8/CHTnFDsoMZ4CVqW2rtTKJlAbbemwhyF5xS6dd7yTgR2Q39q3
         TTHgoVR6lZwYqmPkQNkUAKHsnwrgCrIjquDbQFjoSzQi2HLOU25WJWNe8bWtZEXr0++Q
         n8ovWBvKdDvsuXSu3wT+AZqxDQ08QXVnnByhhvSbRd1uh1Hkawc+b2OmMOALI2ihZbsC
         k8dDAXRNmB4+oOtmA4H9ul2iUAp9Wn5SI5pepMHPoYRoWIf9hMujbM0MuZoFCpqaPGSB
         wVD3zj1ABw9iufj1HY6F2kmJXZFqR9/fMLme2LHClPCNKFv4K+pwEr1pOloFXf0MGCnr
         1SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323751; x=1787928551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vlc/iU0BEBi/KNin4z6a2IXssoOeWKNQCCK9ZmekGRI=;
        b=p7Ob3QjkSEG++nTNhgHYHG/C0lWAniNzjYDvA39nhuWEiWGr60JIlV3f0ghqvQaRt2
         3BpXgjQiEQZIPu14NJF8Yhy7zKCUVkQSCyQPAHQuxk0zGuQszKgzD1YDk9uA/fV84K9t
         uPsd/h5SSw3zmPlOXvuQVU1p7RFdb5f5nEC1pvUcNcztTLiuM9jBPmd3INwvh+cG79i5
         s8x6+P2MqPkxTpCRgLQC2pq+CMqRMJH06R/NK2CGcqzsAHEROPEaYmKxnICRWpOFIoeD
         WVrYq5vho7YwOMe0pYdwPeX6qAbnXPnotecoZF+PcLAy0zTMbJCj9AG4Um9hNcSQtVSC
         u1gQ==
X-Forwarded-Encrypted: i=1; AHgh+RrpcETw9uBIdiJedg6yp4Z4UBMCfn9xUl93B0WOsg5zHG3hu4QiHQMUpWJRbZ/Ba5XAum7GdqxbgDp61syv@vger.kernel.org
X-Gm-Message-State: AFuF++k7G8YEQZL4h+oguITC3OGdBg/qIHiI9q+As0mSCCoDVzum1OrB
	1T/Ccr2ry/RaiCTPXexKtqGF8464fwJeq9VgIalXRhflNmH+x8FDf7cCuFhVO0kHc0UpcoMyOY5
	GVuLSRE0ZLCmsbc5x3XGveokEbCDk8OAyRkutyD5O
X-Gm-Gg: AR+sD111w1bcNMAEG/CDHug2K7HECdnUSBLxcibFCqafkvoRVqwXLOYUc228r6Qw+al
	qJGc0UW8r1ff+Jbn79nV4qNM7aNFuuo+HjVtFWODusSBuvtKzcNl0nE/2FyOtlUcvPb4bHdPwCv
	2tPwtU0dIbeLFarUKn/5edSsQwhk/CgPa9m3zSdwBB9L6AzZO4V0VX2HXdqF3LSOkA+MdOKASjc
	f6fom2Z6+/ClAWmSR6fQD349UYo8WsK7hQ+2V+0s/XNXK2nh3e5LnYrVsFc6Mz2VO1NAap25arV
	cLCpN86KLGYVyAMMP9JytHazSFiKGbFqF7eKkcOzEUG9IaYPCOHhK80D4Xvap8174PC4SDVz/2w
	J1LvavmpDb18bR/MKfxchbNj410QqzRNt/gmPb/E=
X-Received: by 2002:a17:902:d98d:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2d64b0242damr7580045ad.2.1787323750012; Fri, 21 Aug 2026
 07:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com> <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
In-Reply-To: <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 21 Aug 2026 16:48:32 +0200
X-Gm-Features: AcwNN1XIz1KzlKUYbPV7VaC7KEh2VkyaYQONO-MSpK_iCwFkMVBjZQBPINMVB_Y
Message-ID: <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 4:19=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
> On 8/20/26 20:44, Jann Horn wrote:
> > On Thu, Aug 20, 2026 at 7:22=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >> On 8/18/26 21:51, Jann Horn wrote:
> >>> If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently h=
ave no
> >>> good opportunity to block a process from overwriting read-only code i=
n its
> >>> own address space through FOLL_FORCE writes via /proc/self/mem.
> >>> The security_ptrace_access_check() LSM hook is bypassed when a proces=
s
> >>> opens /proc/self/mem because this is considered "introspection".
> >>>
> >>> This causes a hole in SELinux EXECMEM enforcement, which tries to ens=
ure
> >>> that a process cannot create executable anonymous pages.
> >>>
> >>> PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> >>> accesses are only possible when the LSM allows ptrace() attachment; b=
ut it
> >>> is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> >>> environments running lots of third-party code, such as Android.
> >>>
> >>> So, introduce a new LSM hook that can forbid FOLL_FORCE specifically =
for
> >>> such "introspective" accesses.
> >>>
> >>> Signed-off-by: Jann Horn <jannh@google.com>
> >>> ---
> >>>  fs/proc/base.c                |  6 ++++++
> >>>  include/linux/lsm_hook_defs.h |  1 +
> >>>  include/linux/security.h      |  6 ++++++
> >>>  security/security.c           | 15 +++++++++++++++
> >>>  4 files changed, 28 insertions(+)
> >>>
> >>> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >>> index bec6197329dc..3dfaef49bb70 100644
> >>> --- a/fs/proc/base.c
> >>> +++ b/fs/proc/base.c
> >>> @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct=
 file *file, unsigned int mode)
> >>>  /* private_data for proc_mem_operations */
> >>>  struct mem_private {
> >>>       struct mm_struct *mm;
> >>> +     /* Was the ptrace access check bypassed due to introspection? *=
/
> >>> +     bool introspection;
> >>>  };
> >>>
> >>>  static int mem_open(struct inode *inode, struct file *file)
> >>> @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct=
 file *file)
> >>>       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> >>>       if (IS_ERR_OR_NULL(priv->mm))
> >>>               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> >>> +     priv->introspection =3D priv->mm =3D=3D current->mm;
> >>
> >> Is the feat that the fd could be passed to someone else that would the=
n not be
> >> detected as introspection?
> >
> > Yes, exactly, that's the primary reason why I did it this way.
>
> Okay, would "opened_by_owner" or something like that be clearer? At least
> "introspection" is less intuitive for me.

Ack, I'll rename it to something like that for the next version.
