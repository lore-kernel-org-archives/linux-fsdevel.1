Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298F481FBF
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514107; cv=pass; b=RRUphQXg+CZcNBnW0WeQOGd8eoST9WCe8A8ncSzN2ZplJxg433Tpp/qf43iHtxRULIy48YdaTNsU7emGDxE3IuAIUwW1+XqYAOXFOuA+6FseItps1nEB55EakzPhLZurudHztSYhOA/jWUam3/wDT5Abm+jfXE58JCq7lcES7vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514107; c=relaxed/simple;
	bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSZ+8X9daf4BSwX9LoqbPLiyb1FGfWIJ5TCLha00Q0BPG0z+6bmomMYX6ef4E8fbaAREL+R4+/BZhjaDTDzOIT9P7GALY4jAfcsgxUgu3W+ISDVAr1tO0pkaoJKlq05447qYOfP/Gzp23DC8doB/mE/NCWEjuXilLP4mfmcgMIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfCgoD20; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfCgoD20"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso2181a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 12:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780514104; cv=none;
        d=google.com; s=arc-20240605;
        b=L534LeTSpUvwUQKo0gkus9xvU/o6rCSyiobP9evDI7tvfKikNxTEXhFwb0Es3WcaaX
         xend5SmKS1I60azHvYN9DWmDm2p//HkC17UmPW/Jv0iU7jxUjstj9dsgc+jtjpDO8JoU
         pAroJ6GRNRF6jwygZh+5/FIagryjZE/TrN92rSMx/LYd0H2thEotXTF7QjsYwV0tULf4
         cmlTMJp0RdNGVrDe7GwvhTgV9BadnEBCR+LLgNBdeF8GgINpXFbpFyzdZhQ2XXUWCc3z
         j6YoPXDwT5qTOHQ+03e/DalLCJjIxGcR84mRiZSTLVq0o7F1h46nRXwNp4ljCM9RyU8z
         k1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
        fh=uYUH8X1w5SVflt3dZCXNihRDYm/Wz3/arKsO/drH46c=;
        b=TNN09vu1aTee89lgZ4D1pWBWWJ8/NwNKBgFTUr+f5KDzg4DBfAXUs2/UdgX3lcgFa+
         bCHC4LDNOTZo+jfxtfp0ungGMAWlaSnMzsNUejjHQcBBBHJbe77kFQmXSdCDGqXNWD0p
         CXLmdulR9gwnWO/9dRU/kuhtXvkdGeZJfP9gVJyAuIeci5N5iAi8WE7M8kaGvKw1RWcC
         M6JecEC7JzaKi5o3h4WI4we1XU2GifYNaL41769V51bepvSWw9OYPiKtQPKZmv+VgjWo
         Y8arwktPn2KOUQ2mI/PwgvU1HAZI6Huo2V1qrb/I6xZpdF9Ll5s76cGGEXgpHaCQcPL5
         zAjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780514104; x=1781118904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
        b=jfCgoD20x0qu8FZprg93X9hh0T1PTypoAvgZBKJeink+mL18zBqEY2pmwVerCEJwsl
         GkyNgfsCPofojIJhn5Vd3Vk2Pk/J9HMcfJpABhiw6yoEAyK+q4dApFG4OIn0bqfECNyQ
         2oJZbCI9bmLnfOblCoqW15O4RUQ6Vhwd4Z/505wVP/FxtDmKGW+oXozWxRwWxYpMpb04
         5o03yP6rSexzL0vFgJZNBAY+fEm863IlApogxPgsRsNc5tZb8Uj1bsAUr12J+EZuNS+6
         ppnBooS/9tfJ3kDEPidU5nkDnrnLpKoSXs9FIcgPYlHQPwkg58N1spmmlbQS5DXFnpsU
         Pe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514104; x=1781118904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
        b=ATPvQj3gsiSzl+lUxaDDK99ljyEogyExHOOyLAZM1BzpDU2WmP9zMmYBZC58Lu3u19
         P3lqzXUFI1H1eZTylAXJX541rv06h6keRPb7VkC2nMwG2nVmLOLJzGQS4aSuohEIRKcd
         skaxgIT8Qc2cNXZVl42HTWHx7YZSYY4SCcoi8k4Zo/SAO2pS3qVQlUhyR8/qo1fBUPSL
         vrppbnzxMAJ8+MhL4Dfd9MJgHdh+H4hfVxX08gdwu87aTXvrQPFHJeNxPlWLOfPVTZ9G
         2if8fHxi1+iOMHZRRJLIWfALc9pAIJHU4CO5FYMD+TTdrL2AtcoJD0SiI3e7gbd9cJBF
         exIA==
X-Forwarded-Encrypted: i=1; AFNElJ/0qTVTeYJczNAkp7jFXqp7QqQLajwZQFOaO4bk7fhs2+lPTNAwJmBnNB7sjwdUHHp2EO6W2/A+VPuxEqLe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6EXeSnx7jUltRsrw45l/L0yuci2c+uNPTBo6e88Pnj3hjlRjY
	kuH8S7jBwZGXm45YmjnlqG7lOqre3YbYJ71sNQVlE0SdkyRvJInzMScK/w6B3Gx8Rw8444esQlg
	rDK0OLnOObV0ifFeY+DYnPDnNOuL/VjaB9MCbZbfdlieuKdzil17ubkDv
X-Gm-Gg: Acq92OF04Zgzhn+dwHXMN1ScGsWaYyOyCfwjnQyC07mAZTm80yr/V8xBEPttG4g385S
	xvS0t6BY4apUqP+LkjqtdtGVHZEaUWrB4RoRfTq/aZXoQN8KE1oELJHfqeu0uV5c8Aem6XB9Ntc
	8LC7d14QM7VJDphxjkazO6ye+1/CVc+bi5ilBiQHtPXh6lt2TNdMNFIjHvdeoSeaaNd6qDaj6Yj
	EnDwm77QO2GCEhf4TNb9t+gvqTxLwlT4Is+3EoEgIhZHunORRiI+PmoMwDPQzD92m2tFqbKmiWR
	wFFDntKHwkOXkUNI/mD7ZkXteepYD202DC3T69iwTaH6h3YN
X-Received: by 2002:a05:6402:a2c5:10b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-68f129a2317mr14728a12.10.1780514103934; Wed, 03 Jun 2026
 12:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV> <20260603182454.GX2636677@ZenIV>
 <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
 <20260603185324.GA2636677@ZenIV> <20260603190225.GB2636677@ZenIV> <CAG48ez34NaE5DCdC=VQWFRPds6JHwGq2YJDF5e6XUtGPNfQq+g@mail.gmail.com>
In-Reply-To: <CAG48ez34NaE5DCdC=VQWFRPds6JHwGq2YJDF5e6XUtGPNfQq+g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 21:14:25 +0200
X-Gm-Features: AVHnY4Jw9NWOm2jCBllhmHRKUG5CK3R17Tf93bIq0FGTh8la-bdsWtIarmCo4Tk
Message-ID: <CAG48ez2kK2dB4Tva0aNdWphV6BS021A4bf6a_cu_yOEJ8Uy=PQ@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 9:08=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> (And there's also that weird detail of how, for anonymous namespaces,
> the active refcount isn't used and AFAICS never actually drops to
> zero...)

(Er, nevermind, I missed that anonymous namespaces just have their
active refcount set to 0 from the start already.)
