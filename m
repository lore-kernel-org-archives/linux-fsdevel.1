Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3442E8D6
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572303; cv=pass; b=mPmMKbxJSOiMr9dHFML2WvzrC1V5uMHFCeJYra5QgSEKjNIankb8CpnJt+jf1pXl2O7RdUvhDI9RBDR1q0bbA8wE+fJm55fxUE5ahOBDinTYBRjeZcyvQirLlFmvG2H8U9uTNap2ZOyY10SQeL2nAQvVzntXofUn3v4zVNKaEGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572303; c=relaxed/simple;
	bh=LC7hykOo7NcQDgbbnYkuyatZKfLvtqyYnzCxrtoDhEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOjfUzu+HMi8uLJuO7hxvX8cTnXt4WaOdhtYMwpqiPy+LUIwum3MqwQVRWKOQbVRDMRejrnlH34Lz8xF8YRbNDemvveguWySCoK8p8jnRSldRwjosiVmz//gYAbhSA8DL18iYMbtvJ4zU9+NVbdhcz/Y3avbGtjuh8V/ODDxbbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF4oDpAV; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF4oDpAV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so130124545ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 11:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784572301; cv=none;
        d=google.com; s=arc-20260327;
        b=FK8fCziHgkuVzVGWYWkpjcXlk02ArJqidiSXAbZKuf4PyfmTNZ9nsP83Fi+QRtV59G
         +HmYeNIipchlmSlnp1P+UxPVQIbOx3Ymmj7iCg3pF9Uc3xe8WcORPifIZq3iW9yEriLv
         0pJ+p9iu7Bxpehw98yjb80Vplo15sDDpK/Rzw1tpszUaCKVwwf5EdLZph5s42rTCHhFC
         WiKPPAPlC7OTKvHkD/Y7EW0MXU5B5TNJYcTiMHK2JNOKLcl3lpplWNHOj3O2GTyK/CPI
         Q9j3lCTTZ8UZvS8Ri5+m8vj26vHdSBuHjf1skYjyvyKpWnBQ1HfTcAr2umzcN/bSFN17
         IoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        fh=15STgjbAu9KZrvlwE3H9dh+sziQhBgFdLHqcxWkuLl8=;
        b=YQPnuOIcGj7Zy0b47VxRKcYInpQ3LaIf3kck44zsjjsbzOo3Xwnrsvx/lYO+wfX4xM
         vw0rqROPld1PGOyTq0wh5L8PMuY3RuiGZDeyFGquoR/KtzKXzs00f95Zu7xYWDmrGuh1
         JTtmaxgXD0qWLKuI0JQuT7reV47xSozYOOReG3M9bB6/JRGBxeq9Ciat1aKxTVLy5EaG
         NVJe6gRBsmFsfzKHu6o73SlZAivSKma3n0EkvyRC925ulTjiylb2hwM9m3so70h85kdP
         3SjXyTs8UguJHRqyQFUmYjg72bMDDkx5JY3Fxktr0uQkOfbOc+Wu3scwexP6EyukT73V
         6OpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572301; x=1785177101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        b=SF4oDpAVjRYKdSsd1An806F+kBH3rf003d0u/ZUMNNm7Z3eZ/kHMlpnc10wsos72ad
         oUVSW/oegIFYOPHJjIelk0S79rBUhoWc1IxaZn/GFnBqExrzXoMic3eoXfLINQQIZ2qz
         tA9QBh17mfw2HmoEip2+j2tXcSavY9xNk+6qFYmUxbEBLFOg+1y78i/MUQpeItTjTJWm
         BBeiwakKjw0Otg45hxTUrmXoCmRGjkLygItlPBW01aC3soRn+U1ru7O6dzq3Xij6aWuW
         HWrIU51Yw4aQ7Wp9fC+8Ioy3i7m2/hJl55Afq+HIz1ohnbQvRwBMYwsoWHSQ62lpQjgx
         aH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572301; x=1785177101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        b=OHDWWQZPOYXergQAxC5J7GJKX+PhZIz2F7Z2UQrMsFJ07BJc9Zot/tBU8cOG7WBo95
         qvnCdINcmotjb2WwGnE9yIPcGwEDM5EqQoOvhXo1NjP/SGNCBKnGzL3syd0czzjy38Fm
         66ogWDTg/KJIOPS30mdkafKm4B0S/ji/NRPgdTclmeAgXC0y1G9aScP17jURe/WBWCBg
         EomypGwaCV8zZBuIak3VdMTy4IOF9LDidCfadngAXEJ5v+EYgi4OhMs6y0n45VF7A74L
         +CXrxdcCuTY2qBCjeuV64uC2yGauBaByvwsbWIWB2TgTFJtdfBUXuZ6LVHRY3Oxoms+7
         4IQg==
X-Forwarded-Encrypted: i=1; AHgh+RoCSx/P8QcL1Pw4dfuan4FSJvbZTXI1/ncATf1TMvzqh+r+u+CVMS7XWwfjQN5aCI8G94s7HL05iqTltzhP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2u17jsa4LmgM7hwoJG45GFGFQPlSG98Vu0ummbs4RFFVxyxB
	A3uqYMSwq1WuGHIpmPDnPzg4ahbNiLRIJBep33QZmYN3JW7BaWdHWFzOmfk9KEw++szRa0XE3JY
	0hQC/bPzCmFuBPYP9DPpOSt78CD/GjvI=
X-Gm-Gg: AR+sD10+x4Y/ELpZR0sXAvQ2ShMB68ovsinbIqSPZ+4IPtZO0A2v7hdR8uA+B1OIHVr
	tErCz4HcyWncONuG9MYGUCB9A3SJSjwcWdaCEXhyKnDAAsyM1aLUlLdZ3fO/AN9pLkbuBpjJ2w/
	2q6Oy+W9PTSL5up6b/ur0HJ0wlw4m4AXpLAZgZShtaV6SoQnNxuO/gt7XlhdL/FLMpdcEqo1peo
	rplX9JrgYd3QOQmypXoGvVp3encUwzDjYx93DC7NIR5xknV8MstQFIgqIz7hGE+SZw1kjl00ZsE
	sihNLyyftyGtsftG0j8YfnkIORc=
X-Received: by 2002:a17:902:fc4b:b0:2ca:bf68:2a54 with SMTP id
 d9443c01a7336-2cf349b590bmr166172285ad.22.1784572301567; Mon, 20 Jul 2026
 11:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
 <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com> <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
In-Reply-To: <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:31:28 -0400
X-Gm-Features: AUfX_mwvFwr-TgBt_1bjRhuE8WukQ5CZki_9yiHUuJNp8q_cbJ7bjwASItGBHzY
Message-ID: <CAEXv5_hc9x9XJZr646efGe=HD5Y90FtB1m_xi--0wWuaD18EKw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 2:30=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon Jul 20, 2026 at 8:27 PM CEST, Kumar Kartikeya Dwivedi wrote:
> > On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
> >> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>>
> >>>
> >>> I'm sorry David, now that I'm seeing this function again, especially
> >>> with the LSM specific bits extracted into a LSM function, this absolu=
tely
> >>> belongs somewhere under security/.  It's only callable from within a
> >>> BPF LSM callback and all it does outside of some BPF pointer boilerpl=
ate
> >>> is call right back into a LSM helper function.
> >>>
> >>> If the BPF maintainers aren't willing to accept that, then we will al=
l
> >>> need to find another way.
> >>>
> >>
> >> Where this code lands doesn't matter to me, so I'll stay out of the
> >> decision of where it lives.
> >>
> >> If this kfunc goes to security/, would we also want to move eg
> >> bpf_set_dentry_xattr similarly?
> >>
> >> I'll roll v6 of this series meanwhile and we'll see what the BPF
> >> maintainers say.
> >
> > I don't think there was any preference expressed from the BPF side. Log=
ically,
> > one cannot be faulted for adding a kfunc to set the xattr for inode in =
the same
> > file where similar kfuncs to set xattr on other FS objects / entities e=
xist.
> >
> > The question about bpf_set_dentry_xattr is thus valid.
> >
> > Anyway, I will leave it to Paul and Christian to decide between themsel=
ves where
> > it makes most sense for this one to live.
>
> Also, perhaps it makes sense to use set/get naming for this one too, to k=
eep it
> consistent with other ones?

I considered that, but we're only allowing one to initialize the xattr
on the inode here. Once it's been initialized, one uses
bpf_dentry_set_xattr.
