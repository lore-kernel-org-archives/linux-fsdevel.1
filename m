Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365604A5EAE
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057245; cv=none; b=eu6QeOLfZXNS03s1b9/QFXLMcNU7r4+UTU2ycBL1A10pR7eu8Qp09tpmxeRIfyf5LVXgmlXu+K7oahXi904ihJJc/wPRhc4z+Vy6VmWNhNFhJPctizv9MjXqsbVEFeVOOb0eftddYDtps8obkSxCda8c9/z/H4/z2JY6L/LtjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057245; c=relaxed/simple;
	bh=Q/oDrKjoLV0PJ7re9Qc+KtJR5UkROXgTJNC/Syw4ETE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqM1/Dm1m96p4NpG/Shs5W5la1jjm8MpLRk45MsccNaG8c5UqVYaZa16rFukZSgP8Xs2ayIMSMmLaW9BHdTj+G87rAsJtYs+gi8QMn6tLNfF+xfxIrcTrQ7YL84eN3KCMcPY0S8TIKIq7ff7ItEYCqhvm6Ud1+rs5Khb81ph5Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c169ae1cb26so82505166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 23:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057242; x=1790662042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zxmsk/EJ4w4QHvprrsLgwa7ofL6yH0BsSIWlOL221Nk=;
        b=OEQXifYEBjsAIwMS9kvMjKzbUPUb9YkuViW38gzATLDTIm9GBCTYX6+6qnM+rhOVx0
         kdoBvBjtFpuStXUE3FTUQdUVck6jkjD1xhRsJrUih9oIB8XN8nO0KTatdwaed/0UdkwI
         wvie72rWJQzV3cDqpYHV9S1gHVCkjQQ1r+WvV1jSRf2xPza8Pr2gm5WB6xjZnibFZ7hX
         8XFc7s0B9kdIeWKeUja2mBejeMtPihbkyA0gNmyQpiH+rIHQtE7nirm5/qdFMVdpJXAF
         itO3n0keAANYcM8TZcJeYPU/Ymq2c1I41AXMozVwRN5i88jzIys86SwYIVXvkz2rdFoK
         044g==
X-Forwarded-Encrypted: i=1; AKwUvBxh8sth8nqzRmT10cSn8dv4F8bVqLG0kmbbBfr/VIfFiMkbl3qpKo+p681ystkRr3L5ths7F8ft0B9S/jDh@vger.kernel.org
X-Gm-Message-State: AFuF++moo97Ekjj5g4SO7hxden1LrOQaG6/cPTvX4rPogYyS+zcANH1l
	vzav1uptNFwaCppr+n/8kwQIJ2Afwg3Boc842BmHaYv3QUqc0EykTIX3787NVnt9/atKy1gB
X-Gm-Gg: AYBFou3EVPFrneCe/ROoEq+GmkdzdeaMixJaJGLUKynUOGlcO3JtVuEHN9CUTBrXnao
	s496bbjE32H8hsJX989tLbJFg2OucsxCtuYmRbByDOmPXwrBS/I0sPPpvxjaSIIH9VhcckiDPPu
	5bz4U6E/VI/Ai6N+dMVf3DggYO75g/z575VGHRMic3uUPNnn+fyeHSirS8I36KDO0s+EtRvuISJ
	cs62m3zxL5/O0UBq9HQ2EQgUXujlL0461ozn+TwPgzqMwhOmyu5c3soN9P7dXtMXbzmMKEJ1IM4
	PU62sAxhuKBHcBE5bG+P0QKZ0LsEGPh0QCM9JAKU3Fjycd7vHQ1GalixJKoJXuWBpYBQ1v2a/C0
	dOrtvzkIsnzFt9oZKnLwLs7/8ySs4YKfSeyARss1SQPqQiNZ5plAqQEkxISfP3q+5F8udZz6nr3
	Eby4AE4Scr2aeAQA2BWqoZHm2HWAmwz3DVX19JfrZ+RbSAh98jM2U/BmEUP8hr9QTk8SB+v2rJJ
	byr2uNCfaTR/cDezndh0eBG2NFiteJ6GQqVipQVhm/JSGMF/pcgq1oU/iyM9AHH
X-Received: by 2002:a17:906:7947:b0:c29:6bf0:eb73 with SMTP id a640c23a62f3a-c2a8d44d8f4mr132662066b.1.1790057242364;
        Mon, 21 Sep 2026 23:07:22 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa44f9a77sm417622a12.17.2026.09.21.23.07.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 23:07:22 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so228643066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 23:07:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz4UNVPmjnz2vhJ4fKnM9eGb4plBkLQ2E51BnRGzqHm/GkolIFUcXH0R2pdFiHgjMne7uhMEHXeqNdwWrpC@vger.kernel.org
X-Received: by 2002:a05:6512:220f:b0:5aa:62df:cd0f with SMTP id
 2adb3069b0e04-5b8d28f3a47mr500408e87.2.1790056745194; Mon, 21 Sep 2026
 22:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn>
 <20260831-pidfd-get-paths-v2-1-c59ea6a21b72@black-desk.cn> <CAG48ez3vJrbt+qYh5b-PYxmr2txcg3DAKDRwmBwVzNhRB+8Ueg@mail.gmail.com>
In-Reply-To: <CAG48ez3vJrbt+qYh5b-PYxmr2txcg3DAKDRwmBwVzNhRB+8Ueg@mail.gmail.com>
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 22 Sep 2026 13:58:53 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMUT6pUarj-ohTGB9=5u=7osk+8bvyyAAjStsJN6Z3sEw@mail.gmail.com>
X-Gm-Features: AclHuK-ZUoiNUpNllD9s0TdWDgkEMFXuDsvm8kdoP44o6gMCMaHAEIjZzTqw_NM
Message-ID: <CAC1kPDMUT6pUarj-ohTGB9=5u=7osk+8bvyyAAjStsJN6Z3sEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: Introduce task path helpers
To: Jann Horn <jannh@google.com>
Cc: me@black-desk.cn, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
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

On Tue, Sep 22, 2026 at 3:21=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Aug 31, 2026 at 4:59=E2=80=AFAM Chen Linxuan via B4 Relay
> <devnull+me.black-desk.cn@kernel.org> wrote:
> > Introduce helpers that acquire a referenced struct path for a task's
> > executable, root, and working directory. Reuse them for procfs task
> > links and AppArmor executable-path handling instead of duplicating file
> > and path reference handling at each call site.
> [...]
> > +/**
> > + * get_task_exe_path - acquire a reference to the task's executable pa=
th
> > + * @task: The task.
> > + * @exe_path: The task's executable path.
> > + *
> > + * Returns 0 if the task has an executable path, or -ENOENT if it does=
 not.
> > + * The caller must release the path through path_put() on success.
> > + */
> > +int get_task_exe_path(struct task_struct *task, struct path *exe_path)
> > +{
> > +       struct file *exe_file =3D get_task_exe_file(task);
> > +
> > +       if (!exe_file)
> > +               return -ENOENT;
> > +
> > +       *exe_path =3D exe_file->f_path;
> > +       path_get(exe_path);
> > +       fput(exe_file);
> > +       return 0;
> > +}
> [...]
> >  static const char *get_current_exe_path(char *buffer, int buffer_size)
> >  {
> > -       struct file *exe_file;
> > -       struct path p;
> > +       struct path p __free(path_put) =3D {};
> >         const char *path_str;
> >
> > -       exe_file =3D get_task_exe_file(current);
> > -       if (!exe_file)
> > +       if (get_task_exe_path(current, &p))
> >                 return ERR_PTR(-ENOENT);
>
> This assumes that when get_task_exe_path() fails, it doesn't set
> members of the path argument to non-NULL values. That should be noted
> in a comment above get_task_exe_path().

Will be updated in V3.

>
