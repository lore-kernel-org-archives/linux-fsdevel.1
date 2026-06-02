Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6922264C0
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364470; cv=pass; b=HEuld0wBxg0KSD8EGKsbJdghKWS/tpMABnFOObOsTT3xkUYHa3q89OKk6+d34axCbbgdtrUzXUEGIwtT3heZgFS0lDHXTWOx4OS2EHUE+SnOhpOYJm/axpxCvQkB7McpPJD46BD2babMdy6FWyGcALSB/eQnPsqgOPtkcU11iYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364470; c=relaxed/simple;
	bh=kEZufGZmlrAErV0kTCNXRT0PfYnUj49d+VllOF54HYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNM1Uyjds2JZR7ff2W+ASdjFAJC56Qo3isO72npi2CHTgLfjgHfaGDbCZU66fRyTaA2M9Eg/hZ8NxcLNWyfPUE1F0QAfdjhosIh31hw0A0aPt0cBxCNVcskXjC4MGHLCWLgddZva5QuweU1hGZKkvrmnKp+aEUCi3DsZZby3s/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkNPJ4US; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkNPJ4US"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dc6fbf3e86so57930927b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 18:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780364468; cv=none;
        d=google.com; s=arc-20240605;
        b=cHdxOubE4U6FoTRWpvf5W7ssWORAY/lE8TkB71+mGh54B/M/CQMC7+xE2fgNfGi9zz
         ObNRxCmairi2DbPfWtqorOf2XCVdR4tiMp0Og1TyQFeOEVY/NvOpdlqBkTzuCPdn1Kkp
         4RgTWSaLI41JKfk+tX+WyBh70rwBJkdSOqQa/7PHsyyvcKrLDYoar/J6mgYh0sf22Srd
         XSvRgswqkvjmEdukNZEJBziilaqukWIwTElFNQh0aEnscp1pQ/r9LIU7hZOzFugW3cr3
         vfAqIoRhxKThUlqVF42Ih1RHnDGVAHaNfLMSgeTZ3ah4laow5OE2PRXX7bK9/V7M/ryN
         3FSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4NeVtAvgNtQF2A2Syhk9bS53vFEqBIygSlApY3LdQ70=;
        fh=DZdEiShlKBi4sU66Zx8q6yUi8dIeshLXPo4epsY7tFM=;
        b=D5kTCRfixYJYfqqCgc7clVrsI9EK2jXEEWpbJp0NpOvMS32DCR54/MR3bs6WrY8SK/
         fclnyJJ9PsNQnswWI6M5526cBxrSs+cEWJj5dKyBB+PTf+gmNzOEC01/EJaU7BwtAgoE
         o45iSYAOnanMrD+4QmAaz/vSiQW7GXZ6KvcT9E5qEMsHf+W7UBY2FF84fVN2XArk9v8T
         nXCWEd4XGcvTG+zRytLyhQv87XW6UXJr860zOt2HO/rB+E0ikFGOcEuD0CHGo/qJKG8+
         ckXBLWe0Q3HzHO9HSDSLk96xqu6EBodPjFg2n7xUPGVhGK8waz/EN8L7a4uIuaqerBtK
         fUag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780364468; x=1780969268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NeVtAvgNtQF2A2Syhk9bS53vFEqBIygSlApY3LdQ70=;
        b=WkNPJ4USWFCV94dzGz79LCQTTOztD9h1ECLcuVeDigGiNMLAZhXDh5Waac9JH1o5wG
         kOn/ngBXmn+jAyhe0RMYOEDaled0KuLCFYbcfrIjsK8mmVKaBfeRhejuQYU0/Wgo9iBx
         S37njx+TI6b7StMJXUAwyvshCD3SZxMnNVrZjcDUkIwo8CgXz0uTcwSe2Mn1ifpYosdv
         JNstRqee/FT6JQna4VSZAiw1Oj6USjXJ9u1K4uuxLJTj5edm/T/YnrAhk1ILox+MzayS
         yTNH+7K5mvyVz+zY+BLF82nwd9QK2eVyYSKQF1fRY8CejP2oRjNraYfeDDjQKP4Z6r6X
         dX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780364468; x=1780969268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4NeVtAvgNtQF2A2Syhk9bS53vFEqBIygSlApY3LdQ70=;
        b=D/ZUwR4ETP2YWwKDPS8JiTko5EEsAXV+syIlk2XR+InUT54LpN4eQokcJwpdW2w5uS
         aS0fOv3sX6YHLpznrYNCUsrNdjSuPRUMplxYKbi3CL/1oUjHpzTmfP6BAqaI/fbdzGhG
         3sRgb8CgAvf524cy6LZ8Eorur0qtDWsRy6LY2V8mNRuc9WSzoTI5w6rXboZrzg+tmDzb
         ebvm2IoG9cEYpkYZYWF7TpjYTohYsId6LZ3VjQXyiK3bCmvcb2hCd+PKSbSZVlE5hneR
         0MlqfSAq7EWXd/sz77InsHhytgphIeHBq8x4wwiDQcVnyolY/GvclXHbE72LQqRgrnuU
         XgTw==
X-Forwarded-Encrypted: i=1; AFNElJ8HTqkphq54VVZ+V2S+UD8dKIQGVFwPIJlUmI3lx/7TcaUXjfZ2IfDP8KE1bVyZO657SZPNR4yYbKdgFn6S@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBM+w2nKvxbWX5j3oau5FMJiXb3vnfk+8G9TlAyv14PdA1J+p
	Xv2E9KWQVicFgXeCkttkxACGs0pf9hUIZHr6cFyILpeFppTQv4xyN6vA7ZKmXXUv1lZafYZiWpQ
	Fc9zbgj1lD+gLmI8z2wM2MsN9non06iA=
X-Gm-Gg: Acq92OEKhTVr+mBoGsPOerEklYBg9QlcqehNCYZfW65PP544kPlCROwjOI+gbvQ//w4
	BAMKddYtzf0AXwXnNt0vbZHOYHn/dmOXI6wmbDuwgsv1s05t6BcpVNwG/gyBPp7qzEA3cqVXKR4
	Uc5umuwCNYycowuAJgbIMPR1wfPyafgT9XGQMvE9wpMcABsnCmn0YRmDiltYj/VCjwGptKglAqP
	fWuS98WLlrSZBvK0Sft7gqW4gFSIwdjF0VjbSiK8XxZIM9Dc5vi0ZjaSqVjl0UciNHk6AvSoT5N
	Oba0cOnkShKHTbiCCxiQAi2UFdL4bIiyTppuPbUn3nWvzmo90npfomEETFy2CUeyHvRVm48Yxj1
	6yuKpAidkDz7BW0rYcw==
X-Received: by 2002:a05:690c:39f:b0:7d1:c256:b5b8 with SMTP id
 00721157ae682-7e05cb3f53amr126674087b3.13.1780364468203; Mon, 01 Jun 2026
 18:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602002607.110866-1-kartikey406@gmail.com> <20260602004320.GL2636677@ZenIV>
In-Reply-To: <20260602004320.GL2636677@ZenIV>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 2 Jun 2026 07:10:56 +0530
X-Gm-Features: AVHnY4LkmtItYioain61uAttyvIOnrkupuTTYnSetcdaTsQqAv-ltggZyUHOmGc
Message-ID: <CADhLXY5PtSQF034ymmiWnXXc_0KRdrmq+99TJh0=52ZmeNUiZg@mail.gmail.com>
Subject: Re: [PATCH] fs/namei: fix UAF in pick_link() by unlazying before
 atime check
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 6:13=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> NAK.  This is *not* fixing the real problem; it's papering over the
> real breakage.  At a guess - in bpffs, if that's the same thing as
> in https://lore.kernel.org/all/20260423043906.GN3518998@ZenIV/
>
> Prompt freeing of inode is allowed *ONLY* if inode is never exposed
> to lazy pathwalk.  It's OK for pipes, but this is not a pipe.

Thanks for the suggestion. I will send patch v2 with the required changes.

Thanks
Deepanshu
