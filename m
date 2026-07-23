Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56E448BBF
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817801; cv=pass; b=DLZMQ1VLN1nuhFo5gcKNw+Rqc9jfOobfgDieJQhMpYuykZeCOH17v31h3CTKv/kOqmYfQAl6jWCmJNsj1TcCXcV3p+UcRQY1vwJCz7Angtdmf2+RIw59WsBM/O9cGpKBdUKPHmx4Sbcc+PVAYZKq0/GH9a61TRYNLzDcH+KfW1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817801; c=relaxed/simple;
	bh=5Bh13Snw8/LKld3ZLy68siOQFrXb9O9ypzbWa4YekzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5FpsJ4dzhNPBuxrRPbeGpr5EE4BGKGO/pJs+FjCAvOCcEMJL3l1SDHjrMel4cruH6lmgRu3XJKgSMz3OOl3NL5lEH6n2NjqIoGyhyKwBgJwOS/Dgzq9F2+cUSgOM/fAF6mcdGOAl+ZFoQMc6x6c4ApkWH0TLjyIJY0/EylMyHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHZkwHD4; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHZkwHD4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso127255ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 07:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784817799; cv=none;
        d=google.com; s=arc-20260327;
        b=oBiCm/dhY8e/g3gpo5pfEzNHCUjSaVXVDedj/u5QEf0mh2YLiRT0mdaYMy4hDdeP7C
         z3oGPaoDI7c7wfDhRpOqAeDKD5k5qBFKRGv2DrY1wg37HSj176ZH/Xhx3VHw7t52qOOp
         TsE6u1CsA3yqc/X+ONAQO1MtLAjAIDFilRx2JcfSgGbGfTn5GUupQVj9ZrchUMdFzuvG
         zrmyJ52UVUJp83LVzIihvrV5/gXtl+T0kgbHYLZkteNYLZBtDopA/EX3hQTA2cvaJ5Wd
         VbNhZeJpLovMfAu5+LisK9+Lxo2IX1Xemsz5YhmxU96RdExc8rQkQfXQwqFECNkaP23t
         cwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kInI0j7PfqNfBfbUd3Pq6xvKYabvTs/AAdV3xhy9+eQ=;
        fh=3gOwKaKabOVWe5XGvFT085DCwTBykEbJaxMjR31iBls=;
        b=Ad2ccGOc+NLj4nfB1q9IzOTsfrPDwYvAiSVYpAJxzzPBRgM1dVHiBmrzth9FaxXjqu
         sbmt/xmAay0HSviqohcQG45ZS7i7aKryqWQeecxgKOyzkPFBh5RkM1WUmPgSamm8bhLr
         KDDTdYb3byjitpELOhMlh9PygRlq1EvM78ibfx6hGscY10f574AhNPHhIxwqkp0x78bL
         r9u0ak/HCanXpDelgiwUN1G1AmOcz2Lk2JTqW6Xdqlmpjr8pWQypGCAvQQ0rWG7SlL44
         zq7O5fVkEAXkW5rq57mjQL5ngZmO/WBarVYFHx02L/qdWa4o3+S6j0WDz6NR2EyAGsNj
         h9ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784817799; x=1785422599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kInI0j7PfqNfBfbUd3Pq6xvKYabvTs/AAdV3xhy9+eQ=;
        b=PHZkwHD4AYGECajiX1wdnXWmcGjvn7c7wtZqgmhPWyYprrxSljTAFhoXyKMW0swI5I
         +gtd3hm+CQ1jc8lSGrMIpQVXw0GmVPndI9NGRZx7EvXXCmODyRnDjkNejaU+z2g8D4IQ
         KkTWZnINQOYXUSEwfEEUfp0QnqhdEYFhV024+0IrbZ/MBsdJuXPTaazVxjTyrxkYt8kc
         ln73T37n21iLfDLU4rlqoLZY+d0wSM4V0nYj3XotiyM/WbRgbLX73qknYmoFWQsTsm06
         i2BnQafRhSfLbQBZw1wQeKzTD99shDqMJ9xG5hWya1S1m5Zhf8vCJ0fEEoYfGbU5Qc1r
         Ohwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817799; x=1785422599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kInI0j7PfqNfBfbUd3Pq6xvKYabvTs/AAdV3xhy9+eQ=;
        b=NNfL5nngtlT1KaEv/cSl3gGUt0FiTwEP/fMqrj9IFonIHZ0sKH6dlbookPDn7G+jj+
         DR8YfMihMIbKljZREpW5+E1A22CzjT9Qtn+nqaheCp9D0oTj3mf8jrHbFIYqh+KAl+FT
         pIFruNfQesUsB/YhV7moFhDTvq+vz66pA4UMz8UOS10Ra8YNmBX2/NupZLxCXbfJhgz3
         rcR/hgtiYI5gWkMN/gNKFjCe374ZIw6rSyj13nUMsNMWly2mEKsy83Be43O/Npfhr/a8
         ofxQrzPjO6m4pPGsz8hH4rUbT+FTXZyyobOAbCCgc+wAeRHZ6V1Phjp/Xln82mUPMzGs
         SJdg==
X-Forwarded-Encrypted: i=1; AHgh+Row3HhBHyQ16iKiN2JwM2QCI7B0hZSUVzB8jLnQKZglBDEBkVg6X4j4023uRO2mO6JiRj8zsgzrAEpKQrU2@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7voRbSc0mURcrI6xXNESRZE0EFLPUrG9aXx+LGGpLdcXWfOh
	yGA/dUNZhWl2PL/z9yAaPnnLU2vGlh9x6VJb2l6KuFIqlNfaNEdDezqbUaeAWz2KztcE9cr3fm0
	5YbVtbaPM7vBomfr48Hkz9q7vuI3mx+zTfRUgc/hM
X-Gm-Gg: AR+sD11xhpKeUFga9qhgwQX8/q3WLv04dmlQvicSuyXq4F1tGVxQgRg7V+4rt0d3I0f
	YlpXJu4EMumNXyga5LEP5X25Z+sN7fK7jDbDiTP2HqY7r+qE/hvcRUAyXYBTXARYrs0pZvLMNQi
	xVgpAEmTzESawsDqDSO0cxiiMO2D8Z6QdiBw2kLG3gmlGwrDDKrWk5yk1UYbUheBiaK3yqBdOzp
	EXnZDvHVH7Fp5ueHc4ITT9RJWbdEpq0dAqYvZIM/y5+b4dyLtOVISvJ2hJe1H0HOt5BKdqFwGmY
	QnygU75HXZF0xJB6dpg2rMIUtjSYOEkT5y2eBukzfsgk9U6daznUXNlCPQ==
X-Received: by 2002:a17:902:f0cc:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2cfa805b497mr2620685ad.7.1784817798592; Thu, 23 Jul 2026
 07:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-work-failfs-v1-0-3f69b9a9e958@kernel.org>
 <20260723-work-failfs-v1-4-3f69b9a9e958@kernel.org> <CALCETrVDX-PcSJoHFwymh7d=oUKotJQQuh+AzmsA7YQySBzD3w@mail.gmail.com>
In-Reply-To: <CALCETrVDX-PcSJoHFwymh7d=oUKotJQQuh+AzmsA7YQySBzD3w@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 23 Jul 2026 16:42:42 +0200
X-Gm-Features: AUfX_mxwR2szFPQcNEOJk5c8uPwGThX-tGJ2GY340PPIRSnfxESd4tzYNTgrDSQ
Message-ID: <CAG48ez0P6baYhaL4_U_S-wjQX7366WkSm83OQ5ZpUjmu1J2BNg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] fs: support FD_FAILFS_ROOT in fchroot()
To: Andy Lutomirski <luto@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	John Ericson <mail@johnericson.me>, linux-api@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:49=E2=80=AFPM Andy Lutomirski <luto@kernel.org> w=
rote:
> On Thu, Jul 23, 2026 at 4:37=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > Once entered, failfs is a throw-away-the-key moment. The task is
> > considered chrooted so it cannot create user namespaces to regain
> > CAP_SYS_CHROOT. chroot()/fchroot() back out require CAP_SYS_CHROOT.
>
> I kind of alluded to this earlier, but I don't think we should promise
> this.  In particular, I still think we should eventually allow a
> non-chrooted process with no_new_privs to chroot to any valid
> directory, and I think we should consider changing the definition of

FWIW, I kind of like that idea, but I think we need to look out for
how this interacts with path-based security checks and auditing.

Examples I can think of immediately are:

 - bpf_path_d_path() is intended for BPF LSMs that do
security/auditing, but uses d_path() which stops at the chroot.
 - audit_log_d_path() uses d_path()

These are already kinda broken in the face of unprivileged user
namespaces, but adding unprivileged arbitrary chroot() would break
them even more.
