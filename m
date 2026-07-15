Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0723EAB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075344; cv=none; b=nuASXkB8u6+GR+aCh0RoY7ki22q5dpgcTDSy2gsImeMKLHJqcoqSqfNPjwrUiKK4LLeMixbcKs5nE8Ru9cJUIMhkblapnhzSGn25O1g5IEUnLtgPDEYIg1wdsw0LWFubS4PTlW7OF6HkFslq176NFxQUyHOqhLFHqLtGA19hgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075344; c=relaxed/simple;
	bh=EOdouksHbU7HoTYLTd9sTytB4GWL1iNi3aAR44UL+oU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=TO+K/09WqV/XZBVxVMZo5AxK3C27oKrxnm0vxbHH0M8pFg9nzMTpVVzIBzkqtXGhWxiAr2B1jdsn1hHYyaXsGZm5sG5JnNRn3RM3/7EVFbbWkcTnuXH54hc+sjRcsUobyxVAyV4SEtPt4iivXDD/qBDu4YHi/IdiHPcUhpRup9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLVqAinW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLVqAinW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4236017a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 17:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784075338; x=1784680138; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ajpIRi7O5d8LXEs8HVy9pi3Mo9jVPVsznVYgyaXs1BM=;
        b=oLVqAinW/+aH8+l+eReR6zKqFio/TpeaIVqSKX7qGDRdgT2itxtb0jHE27stVpfAHL
         +YLEmcLMJapCgqYhkbaijGju7/ydQzFwYAznMifmX7q1yOjt/AfO21KV1mo+lPhjQo8b
         qkDZBdf9MH9owX/d++6MgVqoXTMlf8WMgfFMJa84eYsjSKaRXukaK2h+bTm7L/i36jIz
         i7tz+OIiN0+G42Pv5oTDCNNTSCnCo20MNozj8Amd2SbR5vRQJCQLQ3vTlmxRFYPht8vI
         HpCDLMSWguE3DqolNlhxV1Kr4BUQnQIQRiTf5rOZV6hFVvNGo4HVwAw4XVYS67KVrv8C
         ZrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784075338; x=1784680138;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ajpIRi7O5d8LXEs8HVy9pi3Mo9jVPVsznVYgyaXs1BM=;
        b=nzTJZlwkfN4k/J2VQqAJIkQJSpxOiuckFSyxQDMoACOoDcYB82bMKoRhmpQiIXqZZL
         0GxEBMp3x3bh2pmxlQ3oeR+dTf//WBkxTF24+2NRDda109zDF2XuuaOlGkXHNW6AmQ9t
         6A/FAsQ5zjEZJmZohpKESLfxjI1jPbFsVCiVOgQgZVd3mbPdUqmyXmY932+Nx3puriA9
         DYBRtGAGZB5nE5ZgIjanqsedKRMQAoDjzgdN2g5RCa1Q8wAwFUlZTuSJflwK5jX4F4yR
         P3hfBfyWsuxM/0gVS72mLk0Uz0V5y7c3gd+GrCTNFcAIu7neocZKjtrF//ftvmcMJshc
         DBbA==
X-Forwarded-Encrypted: i=1; AHgh+RoAkx3tqyPIqdWWSLEF6XMfN8bzev8wC6LKNDqbNu1QbwRiFyznTum6PQTVA6FE83O2ZnhVdK0JNpiaFsq9@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGqc0c2zP88kmuwCvYuOGdZsMG/utp5h0AGM291A6Ri1uE8eO
	DeUVTZWF/F16rmFvnDauWu4NfZptYjIwAJTylkcMboWglMd25x3g+YS8
X-Gm-Gg: AfdE7ck9khtNluvVTPNOdlNJKzSaPeGTlvUPiMQQTsFHdJX1aHK4hktv6+mClDl9air
	jikJAzUwvW4REmQ2OIP8cbbDt+hV5KQ4VH6BAdPB7lTdoumrQwtIMOoU6lCu/OWpPEQ5T+L8WTU
	qR6/tGdh82w4pTwEv2kXd3A849NpjyJ7vlqhDi8Py4vO6V2tNQRbpFzy3OWAdtewsGDzJoV085M
	j4EMbRv8srJHGrPGywVphFdjlQD/Je7H4Mo51wXClTNFyVP3po7ni7fwxLnWyn1tDWemFH1eW27
	FDVEip79KfKEORcvZsbCyRjvOB/c3Or/zjjHbjBceX9JQ2bRWm76uDOdaM8f3J5w1gxV0x/V59p
	i2PxfDvDCFuma60Z+6xJFvzaqsC+tMiZu/p00ZCqGv0XD15gFma++HS6atIybro10txt4NwBDyF
	EYBEH0EZSg+LKg2dUi
X-Received: by 2002:a17:90b:55cc:b0:381:22d6:f7a3 with SMTP id 98e67ed59e1d1-38e2a030362mr682173a91.18.1784075338228;
        Tue, 14 Jul 2026 17:28:58 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm86075098eec.18.2026.07.14.17.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 6/9] binfmt_misc: let bpf handlers pass an argument
 to the interpreter
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-6-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <20260714-work-bpf-binfmt_misc-v2-6-57b7529c002c@kernel.org>
Date: Tue, 14 Jul 2026 17:28:38 -0700
Message-Id: <178407531872.2243172.4159451666378990368.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 14 Jul 2026 21:58:11 +0200, Christian Brauner <brauner@kernel.org> wrote:
> A bpf binfmt_misc handler selects an interpreter but, unlike binfmt_script,
> load_misc_binary() builds the argument vector as just [interpreter, binary,
> ...] with no slot for an argument to the interpreter. A handler that wants
> to reproduce a #! line therefore cannot express its single optional
> argument, e.g. a handler that resolves $ORIGIN in a script's #! path loses
> the argument that followed the interpreter.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
