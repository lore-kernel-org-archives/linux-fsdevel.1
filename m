Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508531A6834
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456075; cv=pass; b=OYsL/e1S25jgVQW7Yc1Mh+th1KqN5Kvh94/bM7uIQXF26hhQ5R/cgnjsatnR6KNfv3GOvDtu4FX8T6pxkPTlfmIBiwRpzgMfP9EEGaJlOTg+tVxnTq185pdGdLzvUxMWmN1pyuZZOZU14RMLzAnBtTA8302Y8mVOtBEmzrgMuQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456075; c=relaxed/simple;
	bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZZUlS2mwMbnHTFSM8jb+UTNT5ewiAHe4dTlRqNuUg8nLMFdHnnl8jS7rlO02uHhXzaH1Z57smf5dFapxMzf6h1Ff7NizBlUEia+T9HtwqF8yDyU3vykLSJpeN/Fwge9sJt6s2WgMxXjrr0XqHJeOFQfdi6t2eOBQevHDub/eus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk/DigPl; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk/DigPl"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c04bf4711so2975531cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 17:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785456072; cv=none;
        d=google.com; s=arc-20260327;
        b=bzWMIrUJTyUANVoJD2ILna0NEZkklvBgcmEx86BbMWVRoTQj+GizRj0h45q2i8iwbE
         UoJK/zl8s/LBOTBE8/PTW08JKcTDAvutJbl7/j0OhljLr0ue9IyAHGCJpUwHs/BiV7qz
         cpV78h6igNpi3bq2Ljw0SXJtV1dWc8IvC/2csyu1F7YN6GB5jDaF03ugi7PLKjYN2zG3
         fwL7TpBVwmNzlZgKHsCF6yWyXBTU0Ltx6yAqaEl7+c5dv4Wg0k52DUl9CBA5hGfxGL8e
         HeEKTYjCjYczSr0/QS2a4qhN5SfVtKsEFCxeeTbUzfRezOqtL8AlvS6LI75V7QFRV97J
         JQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        fh=YTXvTd3g0BS2jubObQSQetqQlFIQxr3Vpmh1J2vgBeI=;
        b=gzn6dbpM8UfQTybatfObfEIzqOL71u8yzlFsPmSuFbqa1E8f15eOPrfx1sk1CfpXKM
         facM4MXZgs+YGj+jTHidv4CFS37N8H+3LGkyrVevi/a/wq4tufKjnkbvkvaczDOIAroC
         w/7+8vv8KNo+sMzH+/jOpNWGxSo7/5vUtA37UnEeJgmrn7y3lpmQkKw+i/8JRJ1zurLL
         PuzfDkYiV8j8RpUz0LIS3iYyj5JkgTyuxocYJbJuFPO3Y2hl3/qwqtVzQH7zvjzQMjHU
         N4GW2IBHkogA1UJonjGJQb2oc+PkV3i+3RMXWrUKE2QtGUtWE9n/3RoO1gAak4GndgQe
         xM8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456072; x=1786060872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=lk/DigPlxuCIVbt879jIb6r7+Nmnr5dRWu2ogJeOmjjYjmD3QHGH4CSuEKHKoWHdhn
         AkdVhyIiBI/9atob2UT3f3XBr+Gwe/XQr630TJhEO8Td2mvak+gSBnKOsvd7JDzA2BpU
         802CBeK1z42D9bofWzkflLi+NCEfsgwcPJc1UKLMxl36m5WuF7T4L4mzzcHfeuyeJuK9
         bcFgGVdoJvnrF2886wiECWyWlwHg9e0BOXhMICgDnf8EmkLNVlCKwPfyw6I5QEhArx2J
         SDVPl59nY1Z+PfLyQ5k11S2DmN7I7ltlCukpdmARMsRI6b57LbPsiay8XnUQ7GT7+xj7
         MSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456072; x=1786060872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=n0T7r7Go12Jvt2MF6rW6c3efiwGStn5DeUbXi/RR4sxiR67fkAkmdaOqFgnIBmctJF
         iIcQYmQKFZiPfRPEWRQLc91g8GrU5cX7+y1ZF5e6eVkgYaQTYcqi6Mg2kc92qMXuzkD5
         EjOCOyeqJzxemqZ4KK9Wc4/P+yQb0a7iwm0aIHYPC3GFhFuysbQk50NOIinPtEXZVvOl
         cAi0B4n+2LvmbLFekNA69HkAH9o+YS5fM2+woHLVEcN9K4GS7yNvAhlcmZ2lB0iI/ooN
         zpQky5aAFIWnwCiF2e8r/sl2j2IzKQx1UhshO8Ykz7t3uWeuI6e04GUr5t/aDaNBRLMI
         pq8A==
X-Forwarded-Encrypted: i=1; AHgh+RrnCLrJ7dVBsp+zUW+Br17C2SC/srJjesjapgVPfKsyIAxEehpZ4aWS7MKc1xr1IVWTLsaw1nKtsmY3U9/i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeo9YRN5ddR79cSLKct4Y5ZlervCryPcbZMBdzGm/MI9D/Kf+h
	6RITBMMn3DQU9Bt1Jwr5Lg3mnajhWZFezd6HBXfacujoVb5heGIU+AvUzy7SHclXgCt0FIYoTL1
	ue3un6vgdhbZB3mYWIzHIVpKq4yF1Z5E=
X-Gm-Gg: AR+sD13Gg+CwicUHm7sRrWFMILjcEoDeWbHXAb7oIECLA5Bi4+ydAeYouAW0Qyo/PuH
	9LgNpTJffsZJYuvbtya86S4rIokz+ebSCbWN/Na+DUeZtVJFYeWQQf6t890aNSRbN3lK5Jya8rd
	eYrJ9dobfh8y0PF9UOmPTsIyk33mf8yYvZkm+A53+CACmW6zik04ZR9P681SOr0U4UBGnHM2cTt
	KtCuAijGCsAcWX1/lwe71SqsDQ8Of+0tdsEp8wjJnrUiNMMvXiWGAafBHHyYv8xwhElAYgdlkr4
	elWtnBDRcU9aPzdBT2KplidsuO/QEyNqwbwizUZ9+z2Ru84imOWwHp2OIsGmF5eg+gQPyhj4I0k
	=
X-Received: by 2002:ac8:7d0c:0:b0:519:e3e8:85bc with SMTP id
 d75a77b69052e-52b4b005354mr130221cf.37.1785456071885; Thu, 30 Jul 2026
 17:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 30 Jul 2026 20:01:00 -0400
X-Gm-Features: AUfX_mzzLAETGk0-GNkiDsgUNvOmEZOv-UFFgDdgdht4DdfS7DnllTiGk_VUitE
Message-ID: <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
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

On Thu, Jul 30, 2026 at 7:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Based on our discussion in the v5 patchset, I was expecting to see
> this under security/; did something happen, or was there some
> confusion?
>

Nothing happened, perhaps some confusion. I was basing the placement
off of Kumar's comment in v5:

> I don't think we should do that in v6 though. What you're describing affe=
cts all
other xattr kfuncs. That's a broader discussion we should have separately w=
hen
folks are back from vacation, and more importantly involve FS folks where t=
he
code currently lives. As you say yourself, the lines are blurry, xattrs are=
 as
much a filesystem concept.

My take on this was, leave it in fs/ for now and then litigate the
placement of all of the fs-related kfuncs after bpf_init_inode_xattr
lands.

Happy to place this in security/ in v7, if that's preferred. Apologies
if I misread the thread.

-David
> --
> paul-moore.com
