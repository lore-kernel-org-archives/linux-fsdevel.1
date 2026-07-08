Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD49451056
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515126; cv=pass; b=eRl9naI1YmumnsIEMCPx/HLim7DfhgSvmOCyDE/JOCkhRB/0m+lEUSPcNFP4t4q6fb4Rnd4waahzlTzux53B5Lj3Kyu6/q9VT3XSJ76Hs8ciuxexCkaCK3oq3HE4gjCn4ulclrsI3zH0/Bf0lqTCW4VSB8uBJucln7p4tyQvF4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515126; c=relaxed/simple;
	bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYpU/vFdT7SHYU9/yiJdZWalwwtQ1I5Dc+ojMeeSaBaSHFicSqSzjy3JhgYAMbPuPHgMyAolG4DbdDwJLKOHCgz0WApaZDtznVEfVuu5Hh9oVPiSmU1AQOIpBW2LvnetOAH9v/hxNilPjIyBoNDwJb3qUWzJ69PKQVE4t3IJfes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ8YmyNG; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ8YmyNG"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so4681566d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 05:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783515123; cv=none;
        d=google.com; s=arc-20260327;
        b=EKcfVgX+yPvK3BLtwsKrGQmxymGdYkTGQsLvP6L+KU0Um7MH9Z+gbB8Q6Iuw3ZT4gX
         StX5goctTcR/15uoMdiA/lsZqoeit0ewgpb3w8EtB7KBBl9ypWSExRksrPi+z/UShOO7
         oYLEKzEAnLlHiW/+Mqp41sQFbzxdPWzhfYX/D9M9fRsuefoGJ5IzowHkoNry+qjl073g
         1QGOzNZyIomWAjkKGvMwcAzXS7PRNx12Ys1LQGRrvC0zpP1ZyTgE0W8ySjWfdnDRBUk/
         0m9aCEb1JDagr3JeStdZe+jvKuHFG33SuqbHYTX7BfemuQy0dWMpW1z+Ry7B8tTJH1fX
         2ETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        fh=zGb5//Orzy+zL0EHHdTdJT0z3cVLWhxOgJSJUHvYPFU=;
        b=ieEK50bR1mapxpH9qFXNHeBATGthouNxULp4A/ilHVpCMWtyKvQEbb/eid3RWK28KV
         0yEnSLs47Lg/gCHVbywiyUrnNrOqYyUsHsML1MUxzFFhqmH35O1Q09K9UD0gRHD4MQfc
         5wJMYZWXiVqmPlGT/YvpD4ek8hKky2JqmOu8/bIxC+ChEa7o7iK46x4+qqTONlau4qWo
         Jygq/PFksVzb0+V5ddI1JGnMElVF4UbOmM0LkTixz+dnkFbwKkj0AMfR0Mb6rzrwyaJV
         ru2UGqXBuFC3PicP+ZGX/Hl/ZhL3ukTnLZ2+qCjWRVtRaRR6qTN5QBryc7rUuZxF3Z0X
         r3uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783515123; x=1784119923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        b=cJ8YmyNGzcUVkugDcbDFSV9hG1XDIYcPXiertRg0HgzcUcju9zF9S1QddQvl1IpWUU
         4k5nyw2V0IVysz1RCrUdJrEDo/h/A2qbnGEkhOL3pMSeZq9aNdhek1gxoF3bPioxNI3d
         ggeFj1wflW8RofhZngweDB2Ewf+1+x6kpdbS6g61gDANdxSQ8inNYw98Euig7Tflxz79
         yJ8j6vynosLrChyjPyPwAlM/tzP8CcmxcP2N9+hHViX91g/XicWPJjt9i8qCxLFKR4ur
         hbNv49Trj68z0qWIkUNyQKuPp7su1TchELfMq/n41YFkTwA8KS5WkUEWYHQo3mp6OZbs
         /R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515123; x=1784119923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        b=qc0GmKO/4BZC2pVqGy3+EDgN8Y+9TTnMeVvopuE1bF3CsZEmR+yz85Acv+lpwCjz2a
         9vuRsJFB/me/qpyHTTO6D0Pq9/tEA8AYqdZZ923ZT+zSobkydNBpWH6a+SqFQoJk960a
         KewV3sYj3DQwvOR8HSNNu1tTYE28E5n4Yi4yvwKsGR78yRB4KH+hrfc2NBUeD8HNcbpk
         cbS00H6HHtuLVIPFfsiaRBcL73P/NSPmFfc7//XDKKx8CBIMgW7xhdkQHdWRaGIa4fas
         ZHwm1Tu4DshfjCWiWwM5DujShdtUd4pUXrm+J7SDeHxUPuSBqwamKZBGBREEit29+YkC
         I2dQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTOlenlqq/W+fKO4gQUCWIAOOCa4bvR46EKPw/PCHnmg26bO85U4jXHyY/pxoMiuz/hdagE3Cyfy8Y4QY0@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPrYmbj18RY7PiH1Xam1M/zcEjw1cQ0LuOb9E71QnrWjhFyAP
	90mDtAz8HNBw6qyegJ9n/7QsphGo89qyZ75jJs4wr4ty6BzLYiJrcW5iKbA2cJ5kF239IAKv8kc
	4e/c/uRdlk02TOMCgPMRHJgWyNXH+7DE=
X-Gm-Gg: AfdE7ckqAE3Rt1g75q0cwBHsweq4rA9j93roYs6/99g58uz7+hv98LyT1EUlheNguJA
	CUhB4KF2rBvrgAfuomtra3IExgxD+hzODG6FqzS0X/2WeNiIXpeDYo0U4IYh0ha01T7Rh/3Jaln
	B9Vu6VcXJ2Kud2V1i6k8RkMK+KlfPsf/DFs1YbUtY3/qST/khpgd8ZEIPNERpxE21PLv23iuPiO
	VMxU99nfoy5Lv4YNbWICoVaSuQ6b8HmYUkzyEEd0ll2r3ZSpVuGHKXdIZbsg4PJLK9iev4uF79n
	ndU0SVVtBPZzJQaZM0tkTvpt1c8=
X-Received: by 2002:a05:6214:328c:b0:8fd:6df3:b37a with SMTP id
 6a1803df08f44-8fec361db53mr20328306d6.62.1783515123475; Wed, 08 Jul 2026
 05:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-1-dwindsor@gmail.com> <DJSV0P2OINKE.34OCOC34KFEEF@gmail.com>
In-Reply-To: <DJSV0P2OINKE.34OCOC34KFEEF@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 8 Jul 2026 08:51:52 -0400
X-Gm-Features: AVVi8CfU37Brxag2yfG62kEk96iHc-RKohKljtHAIy8Sn1Fk6Gh-XV62bqUwhO4
Message-ID: <CAEXv5_j96aUkmSEg4brvk2q-A3SyYzXZ7jyutoXfrc-oDykZYQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:12=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed Jul 8, 2026 at 2:09 AM CEST, David Windsor wrote:
> > Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
> > extended attributes. For these LSMs, atomic labeling during inode
> > creation is critical: if the inode becomes accessible before its xattr
> > is set, it is briefly unlabeled, which can disrupt LSMs making policy
> > decisions based on file labels.
> >
> > Existing LSMs solve this by setting xattrs directly in the
> > inode_init_security hook, which runs before the inode becomes
> > accessible. BPF LSM programs currently lack this capability because
> > the hook uses an output parameter (xattr_count) that BPF programs
> > cannot write to, and existing kfuncs like bpf_set_dentry_xattr
> > require a dentry that isn't available until after the inode is
> > accessible.
> >
> > This series introduces the bpf_init_inode_xattr() kfunc, which takes
> > the combined inode_init_security xattr context argument and claims a
> > slot in it via the new security_lsmxattr_add() LSM helper.
> >
>
> There are various CI failures in newly added tests, I don't think any of =
them
> are passing. Please fix before respinning.
>
> https://github.com/kernel-patches/bpf/pull/12730
>
> E.g. both test_init_inode_xattr and test_init_inode_xattr_slot do not hav=
e
> expected results.
>

This is happening because the path "/tmp" in bpf ci isn't mounted on
tmpfs, rather on 9p:

[ 5.813072] VFS: Mounted root (9p filesystem) on device 0:22.
[ 5.924390] vmtest: Mounting tmpfs at /dev/shm
[ 5.971012] vmtest: Mounting tmpfs at /run
[ 6.096271] vmtest: Mounting tmpfs at /mnt

... which doesn't call inode_init_security. Changing the test to
create its file in /dev/shm, which has a real tmpfs, fixes this. We
can update the test to skip on filesystems where the hook doesn't
fire.

I'll wait to gather feedback from Alexei and Paul before sending v6.

> pw-bot: cr
>
> > [...]
