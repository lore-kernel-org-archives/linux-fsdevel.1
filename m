Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B1361640
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198964; cv=none; b=Rt3b9FXAmB2sqlW2NPKC+N9zNEy0sXn4wD3V6wObj4VzmSgOaJfuF0s4bx3VfIYcPC3nzFWaRj3Wd0VkeHIS/7D7xnBEPhSu4ANY0vgEXClf6sz7h9cQVqh47eBBdNbOk7VOLOJZfXbTOoRYrjMenxQWUNsrdzDKmugMSYpIzbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198964; c=relaxed/simple;
	bh=dzEr3osBLfRb6demh+Mb+Xhthwdtfv/YBDFQk6e8JIY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=gMJ3ZeGJsCD+mFrmH+1Dmp8e/vm7gh5qiRfJUcHoDj2FOhX6BiXh7rWD/NqAvyHHwPZdfsQ0KQLk/OrreXpXC12/wG50QjWWqn5LgxvIpUpPY2l54Wt9nK/nX3KFfFTh6ZLy6zxQRlHIrJDQM7EexuxTdtAHQWOqiJx5ETa89RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkIIOwlb; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkIIOwlb"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so342832a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792198963; x=1792803763; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FDPknGg5ZBDcxMmM/1N7ggpAZ9FP1SU1Vl3EerUriAk=;
        b=IkIIOwlbuOeh6h+EQEtP3S/Ct5YPS5fHNwfPWibYiMlS038iGsYDs/Gmhtq6jFJv/M
         YgxmkV8VUlJKm8b3vm0WSS9Z6lGiAlcdSjejhswyyGsQUOqnAs+ffNQhPjC2pI56eMQ0
         f2V8ZfemWqldTikC9RF2UbdD9k5LDhQh/vXUWMwj3pJKgDuxXoatxRSuRnPP1OL51SKo
         ExfDIwoKflxp5pHQmtydZGo9THe01Vaa8Kumho4y8sR33GIydTYmJeJrQJH7awNGDSla
         WL4//XyBPTmcaaLbdwpFUdlDTxY/QmOm6UeEmFr2rXaFyPOIctPsYVKChG5tF+H47AW7
         GDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792198963; x=1792803763;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FDPknGg5ZBDcxMmM/1N7ggpAZ9FP1SU1Vl3EerUriAk=;
        b=T+LBCjcIjjofSVtHjzC/YA3+vpz23yr4MHR6RifrVdsU4JMZO/s3xOpH6Vn7qJZ5eR
         RD6pEB74cUXvMwSsAoPIBnNpj7825W4cLFh7n3IO6LN5JvNyZP656FWoiLvFM23qzSUw
         40g2QGfmjg63T71Xn/pkTAAAWl6kONtwEnGQwEsO2HywMXFoHx8Px1qSgqe49cvKKL0u
         56/QnaxOgifFj04FMx1a00qrV1si+QY09IPafLR2jg0Jh0OEwnjUfolS6iYINA7dfMNo
         +1sWZxA7KIc+p04VBZDY8pCYHYJbtD38Da+JzzSZiM2wmU6fGstTtHEPjemQSlG0zwKJ
         YZkQ==
X-Gm-Message-State: AFq9FYKU1Bd+zXLpX2Ni8uKy70eefWBBseCqZFM6AbO3kIcYymgQW10A
	N/uN2uuep78MkBB3ErFPL0RzKz93gGP6e+SUGKeYCvkGgTzGi9Fe+6w+
X-Gm-Gg: AYBFou0v9lU3fTeL3GTLx3FVZ4TCwhXbJYHWHqNAMZ1Sx33mH6g57hei70FKbBNgunI
	MOWtsvuRspgDX75qyEaCB9//szgSQ/t7V914yknltR/QWdl2CvwQj4LUfzLfc8OUy0wFxTCAvC/
	00/QnCIIcHYCjSrvNoVcue3j8zleISPL8t1k32bUr9yOXp+Ud9Pj+3NvpNZe4QgZW/UxdatM6Rr
	hzdNd+HDjfjOe01DS8DdG+TV2mISC1cNMU8sF+rK+za96MAlJqrZ4OrKuDTA5u7gQHHXZMfHfiJ
	IFTtoe53LygnqkmamsHBycBdvEaNuGhaqucPkgwnCzk8luaYzMouZ+k30GHZIh2KSSRH1pDit4S
	HPzV1uMeBxVHmT+EW3kIgHPr/B8l5W4/VCrDfRj37n9EfC5t44KIPiN7WnqOm5JJx/VfSDoxfLv
	6dSYnmrNosI8J/nQtBNhwretEqurNc8H6DhCsCf5XnZFU77jyveGBeEVmLJgBPqoIhuxBv8KEFr
	pPpcxJZK0/rlnWkTaUva5gD1oEdj6uQGleT2l9FqBONZIo8qjoygd0uwmBqXM2kIAFzsVwdsfCV
	Yq/X
X-Received: by 2002:a17:90b:582f:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3acee98d90emr1287962a91.8.1792198962718;
        Fri, 16 Oct 2026 18:02:42 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd093380dsm2979093a91.3.2026.10.16.18.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 18:02:41 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 01:02:40 +0000
Message-Id: <DM6PICFFAU5Z.14KOZT5YJO7MA@gmail.com>
Subject: Re: [PATCH bpf-next v1 00/11] fs: unified VFS ancestor walk for
 Landlock and BPF
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, "Christian Brauner"
 <brauner@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan
 Kara" <jack@suse.cz>, "NeilBrown" <neil@brown.name>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Song Liu"
 <song@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein"
 <amir73il@gmail.com>, "Mateusz Guzik" <mjguzik@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>, "Tingmao Wang" <m@maowtm.org>
In-Reply-To: <20261013164800.2906577-1-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 12:47 PM Justin Suess <utilityemal77@gmail.com> wrote:
> The structure is unchanged from the RFC [2]: a stepwise engine private
> to namei.c, a callback front-end for in-kernel callers (Landlock
> is converted, fixing the follow_up() race Al reported, hence the
> Fixes: tag on patch 3), and open-coded BPF iterators over the engine in
> referenced and rcu flavors, with bpf_path_ancestors_legitimize()
> escalating from the latter to the former mid-walk.  Patch 1 is carried
> from Song's series.  See the RFC cover for the full background and API
> listing.

Song's series stopped at
"It is a conceptual dead-end to expose these two modes via separate APIs
and leak this implementation detail into non-core code. It will not
happen as far as I'm concerned."
VFS_WALK_RCU, -ECHILD to the caller, two bpf iterators and the
legitimize kfunc are that leak.
Landlock still passes flags == 0, so nothing in the kernel walks in
rcu mode.
Patches 1-3 fix a real race and don't need bpf.
Send them to Christian, Al and Mickael on their own.

> Verifier fixes propagating the RCU-ness to trusted fields can be done,
> but it's best as a separate series where the idea can be examined more
> closely.  Then marking the dentry as trusted will allow you to use the
> dentry xattr kfuncs.  Nothing in this series strictly depends on having
> a trusted dentry, nor will marking it trusted require changes in this
> API.  See my follow up [4].

Then what can a prog do with a position?
pos->dentry is untrusted now.
Marking it trusted will require changes.
d = pos->dentry is not linked to pos. It will stay trusted after
bpf_path_put(pos).
pos of the rcu iterator points into bpf stack.
MEM_RCU propagation fixes neither.
What next() should return depends on how the verifier tracks it.
Let's do the verifier part first.

pw-bot: cr
