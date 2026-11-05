Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793915804;
	b=Vvn9Wv/VxE6fiT55eQ3WsPhuSy9eG79wcDb8s+uKGbUFPtyIqU9BiBKT3dvvDhwaefLd
	 YXXwQsc+hKfb1AkEpwxpWLDKT5KTvVyri6+1TLTQAZHV9wvmpkpPH9nTVTcabO11Ke24u
	 VbO7qbwuIkYBJPEu6k0PBDLSXFTz3nYVYQk0LRR3LAMHC+dSXuYgB/6JIK5sLmwzYBDm6
	 Gacp7/HxirYGWblGZK2WFfrioyjQH7vajWGfqWrW0KJyezgB9u5JDNNxd8co6c++jU0LO
	 akeNnaExryZLMk1gaQacTiM7quY1jirogqQ7U5yyLU2rVf0aWAsTaEB2ADkRcTOYQBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=INhnVhFd4nT7/Uj5uaF+eYQnNc4krDM7hutL2LALWFE=;
	b=lpPEUOPc/eMbT7LUpYBjWuTH4jCeRAO7jktsAPxkYsCc3z8G/niSIITGL50M09jr+d5g
	 m2YxAds4WN3ywSKxJiZ1hoXcDXixrlLGiMy04QszDqVzK8T7TZy5gqLOjKgtv7FTiB2c1
	 RfdWSlgNvOX4XqTo4dNUfnvgiaCsQy3RhuC7IHEyBfoT8fZ/m7frhamJiqop70rdETZ1U
	 4BR5oVH05Wo4I3iR7ck5/lmyesWTidw7RiigRuvxBUo734Ifoef7jleFG1d+lGb7KA9oM
	 11ZKe9HeEfK2hdiJbcojZHyI1V39Lt3MQ5Cq+ZDPejGkyzQgS4de6gmPSUpObyKsOTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LTjaWOCa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B5F606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 21:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B5F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LTjaWOCa
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2eb0a52d605so15945ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 13:56:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793915803; cv=none;
        d=google.com; s=arc-20260327;
        b=RInf3f4/5UQiJjJMQPJBLMFBOBW/17k8HfnM12wZ2cBnqn3liipOhZ6B7JMZ5CKi0M
         UHwfJTlwtH3HVe/zGEBoLYf4fpVSfL6RIui3NqDKBmyUEuwi3BBSGAqhUtHvO8phaKJ0
         buk3M0CjfJ4OLQSq57YRFgUK2yFjGQyiDlW7+Y0ZyZxssCQk3VUPQePSNOs968RriBDY
         RNLB0zvlHn2PujO1qs06syCtZsxiFWLmEIqhXMZl1bxFJFKeXe9s7seYNuhYeEB8dZit
         tiC6XfRFzpvNXeaab4rTfILhzqe6y7wzieOOHJTAWnbE8Ait64vvsTLEGW/Qs8y3VbHp
         LtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=INhnVhFd4nT7/Uj5uaF+eYQnNc4krDM7hutL2LALWFE=;
        fh=D9PlquNvOT2Rb9S/C38WQ19D1F1UuEOzR2vc7GYFn6s=;
        b=nCqdQJ6fplUjqZMvCIyE86J8hl6BIqW5ZCnGU+uxNW1nFU1EA090wa0eIxt/ql7r/n
         6Q4A8GCH3AMDuPaMs6OjdSNB96vH/so5cmtQfJn5oVzZqsrI3+G1L1XvcY49RLzAT5Sf
         JPTXfvbE92dPSaWPdhl+BKznU5QmPhT54H+uG0/vtGgMwMCkzMIj5X8isR4GrihFu2Dc
         grh3cnIcClfZSq3AlLB9dwTgH78gmZ2Mi8KtuXEfKWeK61PYChGXRFxG0KJgKdo67EhG
         SqzyK+yI6dVLHRm4vKz+Cst+iXAHmNCNckK4057EX2rlnmF7DdkdHRfwQq9tpOR6SEVB
         /ijw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793915803; x=1794520603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=INhnVhFd4nT7/Uj5uaF+eYQnNc4krDM7hutL2LALWFE=;
        b=LTjaWOCad7naX2ksiiBJ/btHekFdZApACmal8hPWqhq5JTA4qdSbJMprCg6ugYPYNA
         J8eA6cx2/mRXlQh0tYfVH5FsHYog9yckNpHPxTA2W7usUF+DXqORKmPcOdBxQaPH04Ec
         JAabj/UWXm1wD6MTl+JJ6as8ddea4sbRPDknOX4MZZuRL3csCqDo6XE836dLM7/uvi8X
         n40i3QvH39VcVbV4DVpZUFrePomkRSepPLYWKpVN/vK7BWV3AlvcKBM77Paw6kuPi27P
         EASG6fnTNNRSs4tGiRCGwV56F221RPTj6p5drVd0yETUkdA5mhmbgKtrTQEPYEgmu6QJ
         sIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915803; x=1794520603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INhnVhFd4nT7/Uj5uaF+eYQnNc4krDM7hutL2LALWFE=;
        b=bYsuIdNaObl24Fva6TsiFwOOvyRXR7iGXQ0lnRu/JM7E2XcNayBdBQD8CQxlbHZ7PF
         1mAvNOk8zfXRXyI6rZTe5G/g9ilLtadJhp1YD7Z6v34Sc+qpjhiWuUoBDyfsV7iWPiiS
         F9gzb7v1VGENQIy2ulWLa5qCDJ36ATSL+YXO2G2inwl1ukFedZ+fLTuPLvjw4pZuqVNl
         aj7kvDGq+w7/k3E2rX0HPpwIF16yxvQCOHC6qkx/6kHI4yAlePbmh7QQUr/5doZUDt89
         U5Bfs1MB8FZimFo7QW19KZ2NJQTL8NyOB7Y1m4hpBWwkoobmVCkCwJ5p+7MLF1eFzzc7
         UbPg==
X-Forwarded-Encrypted: i=1; AKwUvBxrPws9o29na2+blAxgLeffoTZARweiqHG5KS6+050OZTkPodbD4cd5CjWY33XCa6TOr+otFmNsT0v7LbmK@vger.kernel.org
X-Gm-Message-State: APuU4Z8j6zRFFRVwk6LE2IDGTOMNpql8vggl/17Ay30IOwIl1VZPfkBv
	AIxDGuYN93C6ykH7WEZmSTVUeCW+Cjk3F5PdT+ysguyk7LFZy4XIQkqMZuOGFGSNI47uSyUtpKd
	L+9D5vsYmf3qKfFL9WWlllpZ7IzU7Qs0meFKHheoh
X-Gm-Gg: AYBFou3+ZQn5NDywPvjpXJFtD6KEdUUfuViNvGH8lgtMCALVhvnzUgBjoSsfpC9Pe7l
	mWYnhpenmY5suWS2Zh1u03ma4wsuwuze4boosenzzIRtCFPupwuTv3vCi1dJVOkdlsMF2UB05Do
	pY4g6bWnlVvh4zJG7e9a5/V7gMdRVMLLqCjMWxAh/Djqx2kwqC4XrjyyzIMPgCbYmocQEGUuWsZ
	2snxJCjWMYGkd06entxFIAJ78qiRrfVTDK4ePEYz1v22OFdtC0o1qR0nFpDUlzM/Crd3BcWZfL3
	JtFgecD2UPFyErKSvFj9ptPaiCuZzDXCm5cEdc7GOkDWbRZkqD5utXZrQnrLuque255ssvcsued
	2Q9oxg9oFcVBj2o6Dno7eOGRtUxxhqEDKnpinmD378OZbK3oplvNILP5tsnQcuUqfi7aOIlL6Mi
	zx1uo9DMmrS5Xgr5bljiOkbQ==
X-Received: by 2002:a17:902:e5cb:b0:2e9:73e0:2a6e with SMTP id
 d9443c01a7336-2ed45ce19f5mr502865ad.17.1793915802597; Thu, 05 Nov 2026
 13:56:42 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-22-245e54e87116@kernel.org> <CAG48ez0CTxGiZ-q73k8bNhoBTW7xZfWwARCKmmM-WKr6GNBbeQ@mail.gmail.com>
In-Reply-To: <CAG48ez0CTxGiZ-q73k8bNhoBTW7xZfWwARCKmmM-WKr6GNBbeQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 5 Nov 2026 22:56:06 +0100
X-Gm-Features: AclHuK_DIYejrtAv-AIBmnyCAT6PTxuyVU_wOrebkVDOMckVu9fXadnWy_N5Wcc
Message-ID: <CAG48ez0QVQ32Fi_Hsu5ZAWCdWEXvZFB7hNOswT5Qf_Af7YzxSA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 22/26] ALSA: info: let procfs own the seq_file
 of text entries
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 10:52=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Wed, Nov 4, 2026 at 8:47=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> > Declare the show function and let procfs open and free the seq_file.
> > ->proc_open() only sets up the private data and preallocates the buffer
> > now and ->proc_release() no longer releases the seq_file. Reading an
> > entry then no longer holds up its removal when the card goes away.
> [...]
> > +                       goto error;
> > +       }
> > +       m->private =3D data;
> >         return 0;
> >
> >   error:
> > @@ -387,7 +388,6 @@ static int snd_info_text_entry_release(struct inode=
 *inode, struct file *file)
> >         if (data->wbuffer && entry->c.text.write)
> >                 entry->c.text.write(entry, data->wbuffer);
> >
> > -       single_release(inode, file);
> >         kfree(data->rbuffer);
> >         if (data->wbuffer) {
> >                 kvfree(data->wbuffer->buffer);
> > @@ -401,11 +401,10 @@ static int snd_info_text_entry_release(struct ino=
de *inode, struct file *file)
> >
> >  static const struct proc_ops snd_info_text_entry_ops =3D
> >  {
> > +       .proc_show      =3D snd_info_seq_show,
> >         .proc_open      =3D snd_info_text_entry_open,
> >         .proc_release   =3D snd_info_text_entry_release,
> >         .proc_write     =3D snd_info_text_entry_write,
> > -       .proc_lseek     =3D seq_lseek,
> > -       .proc_read      =3D seq_read,
> >  };
>
> Is this safe? Looking at the work.procfs.cleanup tree, the
> proc_release handler (snd_info_text_entry_release()) can call
> `entry->c.text.write(entry, data->wbuffer)`, and the only kind of
> reference dropped by snd_info_text_entry_release() is a module
> reference.
>
> I think the entry could concurrently get freed by snd_info_free_entry()?

Ah, no, this is fine because ->proc_release still happens at the same
time as before.

Sorry for the noise, should've thought a minute more.
