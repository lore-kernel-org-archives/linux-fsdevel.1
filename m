Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF53A8745
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845212; cv=pass; b=PWTXNTzDtDUkTclyOsmBJ+OtdsJkmW+g+I6Ax7o2g5+tvpzPhbv6yJ4g0OS386zv8b2wDnyDv7tq7Fhw4UNTkwLwr0/m/I1XD9m65cmpHmSCVwGUsKqjmJrfzzkp9qjTfHzvminIl29rX2sScBKNuIucRFqzOrfJSrfhAWJlYng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845212; c=relaxed/simple;
	bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oagPiu/M8JJzhHGRma+PV2v45T1fNxXfnq6PXyf8AACB0pzum4dwzFPP5oZDsNDk49Nnx/kAjUNjukI3CWDyw2kOk4OkfP9yPQaCitOrusikFsfaB9zKEZ4P0ixR7V0L8D/ZiHIjpYimoyQFo198NMemIu0uYzcJyiweryqTvzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQSgW7XY; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQSgW7XY"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8efb708b1a0so29217406d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 11:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782845210; cv=none;
        d=google.com; s=arc-20260327;
        b=n5vrNvjY7MMEw9U/hTkNBlGzc3hsiEWowGE+Zrej6MK/ssvhYsc/lCFSLJuD9Ua0iq
         8XouzCHo1JdhiCT/VOQYn0RwSf+Im/inVsbyUxCXZnVPb426ykULdEFgTYrM2Sf3PcJ2
         QKCeUUupvoD0yColVNVISh6wZ8dtdT1it+7gxyT/NTqirV6nMnl7mK/b/XTaX6hONCtU
         e/N5zlw/uvGUDSUtVlekKaPzmbI2ToANU8XzCdbW+c08L/HWsYWcfcIZ2IrDv/aUjTNC
         ZLaqGlM3ZkOKwisUAkgf7wCj9/7SflF3XLRzUa2sWZK6fjOcHLzWpdVfswQFLQdYoJ5q
         9Y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        fh=cWNqvlqG8PotgdnfUZs/97iMPzFVD25gEhEP5nQzhrA=;
        b=s+ofTF7gNGVoNtENtdaxO9nux75E0WyaEb7xCQS6YLuwwx2GeFCWdsJNcsXEA+s6Uk
         9WkB8awMANHTmeZfhKysmQJRI2F/UanQDnghVN/gbQ6v4E0VTIPoViZHm2jcXmbSiqim
         WsAM9cQVwXiiI2UhmLiHjhZVl0E//rCU/gdMXuwCg4JTOgLHx1s9ZkTFqsHCY9mvG5m4
         DETMOALvYg+n+GO7udkNWw2nQZgb/Y9Qhc1bOHid2Y9poEWUjs+bdZ1qk8sNbuH+p4ot
         2pFF0xOmBZJKJrp6exNb7PxfFpQ8pyfnwQLB01bijCop4Nez81XAoD2ztiutB0pwZmuR
         dECQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782845210; x=1783450010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=EQSgW7XYwFqpR2UhR5oIjGjz1p7Sl5z7prkaHtU62QYm16o5fwYNMZbZzXDw4N1o7w
         TjaTc8/oiqjtm0zKD8i/CcS95pH2dm+43MADe2rn9aMf1hKPGLdSdl+rh7nEvSKdwdWb
         QjR+GW8xwXjKE83wXgRxXBKZFIbpxBvEorTFKDTnaw6FQqAGR1E6nY0qU6hw6SonOJ6f
         UnNgIa6B4mckZ2hxw1SIudwaouFYge5A1ubJndzfYxye9NPihpkUAmXXjBYL0RLjqY1x
         hVUSvSmtURF36OOyxm9jT4L44uwrOo02x0k956HPazkIOlQs3pQRuCDykMIY8f+Jh/HA
         PW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845210; x=1783450010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=a1Qn+CqCaxZYQJvz68vKBxQ3xirpdt2RZV4rr352WwTu4Uv9s59dMcOjZ7yH9782Y7
         Vmx1qqs3UJW5w/4nEzc/9ZIwgFx0COw4gGoxqVHtJsNIQrOOTmqUwoiouC6JssyOKfUd
         1lOTvhuRdscZO9r+N2X4PfH/9lYrLxz7J55sOO1Prig26IfQNguJW4eJ51DSa1Io/GII
         CSGmi6bVi0tdE/eyErpqyjyidaKj8RP9pLqrE3Ea02Pxk2oUgOCZtfji5q2yQv3qE6C4
         Z/dHtWqlXxgtMWACqYqm04B1tzRIzdWhXGxq+MABB5wT+MI3odIl7ixGhfW6dk4iTZls
         GyBw==
X-Forwarded-Encrypted: i=1; AHgh+RrzzBA75RsmFPE+iGOdPbezNvQsqJ3wHXtiUb+2XTa/QLHPHISYsYFn59sJNPAJRt2fWWw2Mzndmsedz59B@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/uUKd0QRpEJLIWNPfuZn9aWdVv/DYfnwGybzA03WnLvPlDXC
	tcoqiwp47KixpJ0SU8oju+kFvxuXkuGeU61fizP/wWAoR4rQXyYwepCDF1KmSsDoeyHsfRx74GM
	l85MrcWAGzJS+bE+8i5TG1QjJj2II+AU=
X-Gm-Gg: AfdE7cn09ygZXjGvfHGDWwKBoHAW1C/IGj6FWKDJhMJwEmede+c+DTM93BJsPfTZiqs
	+I2qQXC074eXAIL8lEjWKHMlEiZDpxXpYXqdyV/o5+UzLUZiFkUjPRBSRlt+KvFgq8t84K6rJKG
	5OndMYFYQOkjJV/60zqUAhy+iGJeyRJA/PnpVszR94zB1b0mhkaamombnDH5RPH6ieXB5c8Ffdp
	mqKOfjSOxFpA83o1x8wwUA3znwGwDhjLM9aBRrO0LM75VdFsbMZf7n+sn/P+EEtCZyHQySni+y6
	j+QVmB1OnZBnGt8TlFt6NpbB5Wd5AEOnvtMu+Q==
X-Received: by 2002:a05:6214:4d01:b0:8f0:b08d:1327 with SMTP id
 6a1803df08f44-8f1bab7325amr66906576d6.20.1782845210237; Tue, 30 Jun 2026
 11:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 30 Jun 2026 14:46:38 -0400
X-Gm-Features: AVVi8CeaiheJ3F5i-jO4LvtVLGlRB5U5ReoDcpDUEtFteA-6-xXjOCWxSS0LCkE
Message-ID: <CAEXv5_jCoYbs63RRukH44CMCxiOFzvWWraBOunKrgTVw+inUPg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
<snip>
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there. Anything that's just bpf infra
> specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bpf
> specific helper so it's the bpf maintainer's call.

After Alexei's requested changes removing the attach-time checks,
there's really not much left to go in an LSM-specific kfuncs file. The
bpf infra plumbing for registering the kfunc and bpf_xattrs_used()
seem to be the only LSM-specific bits aside from the kfunc.

I am willing to put this code anywhere. I've tried to CC all involved
in all 3 patches, even though there's some split in concerns.
