Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222B367F2F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591203; cv=pass; b=TcVOXTViZ+gVFE92VP/4KKCOCCi91QqFUgu0MuKY6PYNgRh3PVepT04BfHt63NPf/hETAx/WjJsT8+i1xmxIg4g3r9zmW/pkTLlDxfA/PvoM+BFee8c1vpG/ElfiUAdfRUjrFCXUjxbVA3DIyuncyEbNIHLowEF+zRnL+O5vTPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591203; c=relaxed/simple;
	bh=RetglhChGs54xh+G4sIllqLQaZbHa84fR8ti4Eb52Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djX6aZNiWGyDCGIcHy/+Kll8zP1yBuFIlvOYEwO+WpT5VKSyn+WrpJHKltXPMDFer0wlpJpeRki3f0sFgdVutdKuqfo3NYJdHHmseHI6vV7TibH3vqfQBvbocfvywD920iKkF/+uhZ0SBAYXWJwEaDhL81z7+IOB8KC7cLydr7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo7CX6da; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vo7CX6da"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cede6375caso4985ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 10:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787591202; cv=none;
        d=google.com; s=arc-20260327;
        b=bwR0tZWsBVTTFirhxh9y27rhcDrSq+dC/7GyowgTdnwJ1+OS7vmlJM3UTpJurwDK2R
         1FifVJuXHh36CA8efa1Tg2A6zncN4+FgY0x/iaXWbOeSbdM85Iv0SmRCpPfy2vnZNBVH
         Cuglzuznuv/QGX0VDKGpBZ1QFC/nPPy4GYVhZ6ccixhN1ck8QcAXL7Rq+p6rPxfQWIWp
         qejtBrZ9pmNkVTJyvkpZ/HaRPL12+WrWH9AujcGBx/2RCBDseIut9GPmUHC/84aL87Qd
         KGIF9yn1XyjFkKA+uK/+38tzHy8tl/w3tSRjAQLdgffjerEwz2gGISc/UQiNJTfy5ctM
         8HOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wBrui9oca87xmLJo5FCru/sywwEnBCWCZyUpBYfq9bA=;
        fh=+qMzaQh5gh35WeuXfPqkrzWXAs7uoJIKnPonJ4kPw7I=;
        b=ktRlnIorxSXU2haHx78kALtKahuRlNe5WJRwXHEshgjyV5WaKIGmhszvIbKCyDRU42
         CrQUvOKV9xD5JPos+zcrLaar97xl1qtpT+uIXgKJcX4MM0IbC5uCeomkr/yFr1FYpt1O
         I0gJT3a7ifZnxMS+kCbCfpqi5NtQZrwV1m+2mojeityAKlV15c1ox2jtZ2VjaOIbI3as
         LJBIkL8sckpPGvoCjmC31PJt74bkSV4z6NqC8xxekOjqCnRtvdYwOie8aQOK9+fFRoA/
         iaYNP4TQnltZhYt+Fl5HTBo9RWdwn2C0siw76hD8p65IITlMCkvnGG77Rjn7EKj0Hp/w
         jxBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787591202; x=1788196002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wBrui9oca87xmLJo5FCru/sywwEnBCWCZyUpBYfq9bA=;
        b=vo7CX6dacDq3q2MBn4zKHTMEovNhzBuyfUC2ySAhPRikC6MgthlA3DcavDh0Du4RKb
         vNhH+ry6oUFWzx5kDriVlQlsFp2awFoahbHruVN4841x5DU670ckNINOGk7vv2AsPCeh
         alykxwXEN/RfBuR1EjJ6cz+3lYDIyIE9QC4z6QOM2AGpwXiHZt40a3Z3m4/E1sDcRDW0
         15M55ELxms/ZwscMIDMmVi6vHmZfTtzu8VsHF1QzFn8lzT+6XO+FTdxpmK+6Lb2MuFEp
         RqqBhFwJ42yPIJgd023xLdyyb0vD/PeLT90/WT+PajJWfDK9UmFvIP6UHkzqWPhMinlB
         0sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787591202; x=1788196002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wBrui9oca87xmLJo5FCru/sywwEnBCWCZyUpBYfq9bA=;
        b=pFQdcbY2H1Tj9z1H1r2EnimqvTVrs13bRJo/j87Pa21kUw80URn53oPRYiGw2PTY5e
         1VAjSN97Hsc/v9l9F7f7CXiUlA2ucv2ujx4rgU4wkFkC+LbCOxavvou2iKCUWhNq9vJ/
         NRoOp7f0p90Y9RfVZewvLQmylJmFUlKJFOqwiBo2J301b2GG2SA3918FyOfwHWiZ8Hhr
         PDCy5TTsGfBh3cyIrn70ZeAiYJ/VobuKgQdOA2Dtjdp7JrnDKL8t0c2Hah8eHlN8uZX5
         gqrU5MS+JRRzms87dZHxDmTxkSAFBXhnecwNdSstpPNlrmMfGz5KnW7I0aRTOSoCaKnB
         9MuQ==
X-Forwarded-Encrypted: i=1; AHgh+RowWUsCEYWN36n+EsWgyI8w8B4OvjuJTpLf8aTlrYNhgTO8SDOehervd5jcMVFtZhIrYkU5zZW93441guAR@vger.kernel.org
X-Gm-Message-State: AFuF++k3u8CVB/ld+Sb2r6nXhtWgia2WOn8I4ihuydAbaqv6SlNcnZtS
	Uyoak5whAKqDt6F9g70hNJDg4lB2DoJChQRNykdiYZWDQs6h8SsYqmD3cT9BsHd7InsaOQ+UAQD
	4i2cQZnmc8gxWkILGhs/j7gBbURgsF7BVhogaNCPO
X-Gm-Gg: AR+sD10LX7iuXuk7QcCxJj0KlwDLD6h6owHKX8/tFpY6hwj+e2UAYDl5ZgKxqyZ4Wcf
	IylrCnReuFCdzpbFM08kVJMuRgzhjiUeDxTZ2RyVr3Vka8Ix58Pve8j4pFB4oAYMj8356+G7qdk
	dFQ8P0nypTUN2fW7d2zMOg3Wh5aF5xbCiswAxXJ89JCTUE2smPQAH69iZGv+NNyRLtc10jZmxwt
	Hu5WIAx/3YC51Iz9oQuuZW8vXPR74OxEhjii6FIwrxktVtoXUURd69YdDu8QBoohz5hb+4SmZej
	/EG627e3sF8yCnidK/IESu+89fRkyTKZKwHmPMBU3XrlvyEh7G0jenCBGPGVw2x8T98tDO2DTwL
	CPOtAiRp9Vjbic2Vjxgn+Ehcbuo9wkeY=
X-Received: by 2002:a17:902:ced1:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2d673b9afe4mr10236935ad.9.1787591201205; Mon, 24 Aug 2026
 10:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin>
In-Reply-To: <aoibvf6CY99IXynk@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:06:04 +0200
X-Gm-Features: AcwNN1XN1HjALO-7sEAr3yIwV5QVslvlMZpManf5842ZQgDGGQ6V_1u_W3SFNwE
Message-ID: <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> OK so the whole thing is:
>
> mem_open()
>   -> __mem_open()
>     -> proc_mem_open()
>       -> mm_access()
>         -> may_access_mm()
>
> And:
>
> static bool may_access_mm(struct mm_struct *mm, struct task_struct *task,=
 unsigned int mode)
> {
>         if (mm =3D=3D current->mm)
>                 return true;
>         ...
> }
>
> And what this flag is carrying is 'hey the reason we allowed the _open_ i=
s
> because it's looking at its own address space'.

Yes.

> I did wonder if what you're protecting against is even a process updating
> execmem _it_ owns, no fd shared anywhere, as something LSM might want to
> prevent even so?

Sorry, can you rephrase that? My goal with this series is to let LSMs
block a process that tries to modify its own non-writable executable
memory using /proc/self/mem; I'm not sure if that answers your
question.

For context: In this series, I'm using "execmem" to refer to the
SELinux permission PROCESS__EXECMEM, which essentially controls
whether a process is allowed to create writable+executable mappings
that can contain anonymous pages. Additionally, it blocks creating
executable mappings of S_PRIVATE inodes. There are other SELinux
permissions for things like making a VMA containing anonymous pages
executable (FILE__EXECMOD and others) or mapping files as executable
(FILE__EXECUTE). FILE__EXECUTE is granular, it can be granted based on
the security labels of the process and the file that is mapped.

> The sharing a /proc/mem fd seems like that's a pretty dumb thing to do in
> general :) but I guess you have to protect against that.

Yeah, it's a kinda weird thing to do...
