Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAF2868A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805235; cv=pass; b=fqRvo7BFL+QROO6n8xPdrOHCCerMrjNGFz9aetRb7yp1CjDFc2fZQTV41UXIzATWNUnckPPWYiVs/7CSQlUl8/1iIVh61S7IhMTU1GByohwVkRj2DlJN1auMNrDxRLkMFM+O2JVwjmA24iskZcgTyWPoyx9LUb93HqgVnn0rzfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805235; c=relaxed/simple;
	bh=7CWZKnF4fD4I2Too+Zira9WctIofDbV0eEFuGE2wou8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFVcPZ5mPoEtsWFPXGoD/7nRXrJqCqumP6jJpCOYGY+kSOaZuNs62nIFMxahMbhXRVkCCkudhlfevvtcxK36mwD3xhzMkWKP51rMCX2ppUjvUMxm7J++e1sN+pFr0H1cyJHT2ZC0P/kQqEfExhtX3Rz9gpLXr/tB0wyJyM3PocA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vN9+T35A; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vN9+T35A"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so180a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 07:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805233; cv=none;
        d=google.com; s=arc-20240605;
        b=hCA3qYKbl4k5Z9Su1ZbSfgU9TH6a7Ap/P/AqIRTMsX8a4qi1kwzbLKTbubdYufbBwg
         AIUyguelM+rEwbSYu7GQ7BloYijPP/XNNgOPGBwdhaW6cwBSOdN1mhCwcuteRz8vrLQj
         aNtRnRMSpQ6VDqLnaKrVH9wQqXpnH9FTzGSXjBffNjCY5nuaQ95A1byMUCwUEWSv9+tU
         ZsG8vHArNSoFel/NiJzvD1pWzKUZ6ISRUjNuH+02Fhsm0odtTAEE3K5S9w7jtjJUR/eA
         9eRuSYNx6zpR3QxKDmRDiDbVWcuBYcWczM0rBMfCa1GPRqVWn4hqvi7S96f8ec5YbObS
         JhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7CWZKnF4fD4I2Too+Zira9WctIofDbV0eEFuGE2wou8=;
        fh=MdyAgi9QNdEwY5/sTUeMnce19tpoeLZHmCtb7/6WkD8=;
        b=ayHpbqfslgp7dDxzoZPu3zuoVsZBeonHMo2EPyy53HrTZNvOGlT5mhnKaHPmLzzgdj
         onHu7mUo0ybTIXsH0tAvE90H4B+EVWutmcobrpTSLg4BmqVKDz6MU/h+pae3rcCHk9qJ
         Grtdc6Io8/SKrGBFmCeD2+LR9RnH5Jq58/gW62o+zLcp3jbt6h+eor5mpqb0Tba9giKN
         E0Hd28tguXs3Cv6NlAwEu0e9RHGDjfx0Prg3LMdaLr36QdBxmCizO5V8y4uTEZhuT/YD
         6jKxx7EZLJGsG5pGECayw2FBpb6PcIkbgFMyOB9FmZXC8ViMGexnew52afr912Wb288O
         t65A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779805233; x=1780410033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CWZKnF4fD4I2Too+Zira9WctIofDbV0eEFuGE2wou8=;
        b=vN9+T35AXfv50Akk6vtsbYF2nFJKLdWi72cOx5ZoAVQ92E3QNeLZp00B/ykXL3DXYH
         zY1+ZSRgw/VnzBaxmdEaNehRkoOlk3FvkYJtWLltiLwMltQC4WsAr883LUHBHTxTgrxv
         +vhHBt8hlRVRxWUrIeMzU6Zp93DuYo6iEgh+pLVPMUJvgE4iChlHp7iyouuwrAI+u1tx
         zDBeHyNq9xhrxjQVnx5pb8BmfC6JEcfIJKvwRWbGxQHi8vtE0PxgADHeXlBvN7qXtwdH
         DI81E1E+f33Yu/dexdW9BM/hykJYZYBrmZ9vCGMn2v7o7b7CgX2IKJuE4gpQcRlwK5DZ
         +/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805233; x=1780410033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7CWZKnF4fD4I2Too+Zira9WctIofDbV0eEFuGE2wou8=;
        b=dDGiNYNSKKYlQh1Vc5GnSM0Xa7ktQvNmt7Y5yblgS6/2Tu/Ktvc1dTl1c0T+OH67xw
         qji679H8GuXhnq2c3jT13aF4SAJ/IcNmKvUv1rhxglsJZ533jPO4x11tHT93vGSiKrEx
         W4XKzwo1Hi7HFNdGT0x2PYpy44ROcm6NS2WUDpX3XtxyXx10yBNOQ7udsSXLHMqKNuTg
         gwp2SjzQsvPu0gT58tZ7CZ2tPlCmgg1peraeRDAMcWx3ElrQCNDBBxs8qmmbuubSuiMl
         J/jip/dW3nbUNgA0z/zLKfrg1sIJWZipcG3vLw4QPEEflcCp1NVo4PQwMHWtbbEtjFgF
         hmXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nb513CDzwgh8VH5kcw7eiN60QLfOCapkOo7tqEa3HTsTDLRwiGewKiYGBmEV7OPWYsRvxdOQSer2/KEqz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DRNWtNvdbRt25OMPCuc1/FG/hmKlKlZt1Q5vH/tZuf2yuw5y
	zqWD9pE//NMEuX7vEEy2U4JKyDQBx3E+21RPURzDZwD94MjaM/B0MuMmzmNwnXjdhFmkoKr8iLD
	6rN+iKVTzfupigIsu8uKLVGV0QxtA5h5vxlPSii/N
X-Gm-Gg: Acq92OGMEDFPPyqdsyaH9hSXZFQrTVD17yEWkFplW+aitwJ79PN9ht1OLKiDROKa6an
	l5UgESoczBHp3ic3IAW+eowEKW67Qe1kObfk8EPkLaXmajfY4jEcuaF0mBIGR/batOUM05io7kc
	cM8rxYYwuWadf/H4CLboWbfjXcOrmRwQt6fvsS6hIHkpgAkFFaCAatmzfVMLzh54nJ5H155T3ZO
	J4hPMeGI291JHjCVPpNQ4iGan2AWcvgBad6E/Jq4Yb3UmTxuXnkMXVAR9iPY9nPYGCfT0Q2k904
	GVkRM4UZfLvop/0KBjxxi+j0/ABxPRUsw4+cdpIa2D/air0=
X-Received: by 2002:a50:fa96:0:b0:671:dad9:8caf with SMTP id
 4fb4d7f45d1cf-6890a240863mr120407a12.5.1779805232369; Tue, 26 May 2026
 07:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <ahVeT9TTxlJiW2Qu@redhat.com> <ahVrgomLQ14ncWTE@redhat.com>
In-Reply-To: <ahVrgomLQ14ncWTE@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 May 2026 16:19:56 +0200
X-Gm-Features: AVHnY4JPFyO-HcZfBytQtZyfI926iiU_liXFjEs1d_wK1OpTf_515g_lKDLqDdg
Message-ID: <CAG48ez2qviMSwsFCa24NToscQ1E8ti8e=vinn9e8kYWDJUC82w@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 11:44=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
> Perhaps proc_pid_make_inode() can record task->self_exec_id in
> proc_inode ? At least this can help to fix the
> "if (ptrace_may_access(task)) mm =3D get_task_mm(task)" pattern...

Yes, I think something like that might be a good idea for files that
access the process in read/write handlers, though I think recording it
somewhere in file->private_data would be better than putting it in the
proc_inode.
