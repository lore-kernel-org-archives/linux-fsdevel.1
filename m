Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85432C92A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778756; cv=none; b=AlvLQXDaqteAa5jBBjBuAlDtIa52CXjjv9ZsgbhRoKZJm9Nkn/kCKWKUW1HZZ69b9s4C3dfffX8zFOeCLrsZjyogYM4GZ6V10NW0viLDUmAZWwC701b3iNyNo/+t8gNaLSe4P7/4MuvbikknSId92sKh3wK5TXTYzoLVNfGZho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778756; c=relaxed/simple;
	bh=ZK8ZdB9vqMtUGtjEuw7Wls8+QwjlMmCewXLKeFheOhg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=firfPdN9mE4wfHWcPIv6CRBGrIJKN/OK5ne/Na+601dThfd/g+soqUd6tzm9IVUrSCACZDcdug7ua9nHXAnccZAO8ipQU613Qmtf1N3Ti2bETU4mTxdPQImKHnrnInk648kgKhsaYvo+HKxBB/z3ueuYjOkmWmqGvPbE3nYN8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8Hsce/d; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8Hsce/d"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so137952a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778755; x=1785383555; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xmQfb7RGeHqBIgAxcCBU2i2fNRwtMMc3p7Xugp36EHc=;
        b=m8Hsce/d5AHAG9pr/R/ZDwM5OK7cqEeVIxr+N4OXVUUhcVR4FekJ3YhMquc9jTf2Mc
         1nMv5B5KqH08xbwaMwq+20xklmqeiZMnNYc9C+ST+Zr2tYhVkCpwKemDIs2GqKOHCFCK
         2hgyGYR1ZbtqIbSXFO8Cl5c0hXHhnYQaLdSF6mAQ1JcFL2HXdKx8xVGfAywANK5VyDaa
         yo2TnJicSDgMWq/YSkWqMu5npppYOj8Vx80WlLeWE6oyKCQ3kUYI5xMoEGkycsT44chh
         wSGDOLczUJ/HeuzG54UZEYY82uMBsramfwkOcguEAiY/+3N7uv8L0g6oh20VXZDvH6qF
         cWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778755; x=1785383555;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmQfb7RGeHqBIgAxcCBU2i2fNRwtMMc3p7Xugp36EHc=;
        b=OGPd7V+Tj1MQ5X6/G2D21nn2DKD9euIBTwc8lcc87XB0vl/pVRHn+PtDrYSujVMg27
         nNmIpRj7xFqSBZZCeLAOBwbB/k46NUoe/tFk6s256Sghcltjnl6EhhHAy1rzbZQciRLn
         C/kxVCmxdVNOocfbma2yzyuaLQPMpRPMM6/650vM+3L0zRH+/PNjdNK3DINP4Ms9n9pe
         vGuknu/EQpkd5Apz5htnr0epT+7kkjZq2fpx5oofv/QKrAbJKDn6/y92m7t9CNnT/glU
         a2UWPR3T8cARX/GSXpmxL5/h0pKUMpyG1vyccaTcKWPXe/l8H06NKEmOa9fpIhvp5cNY
         gheA==
X-Forwarded-Encrypted: i=1; AHgh+RpArXfBMauFP0knQGbz24HLUsfxdHLtyT+3edKhQzskjMcSdaHjU66lsS1tn4zwn0lsDKNdK2dQuOcrPsrC@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKg2FAIYmCqDEByB/KkcSQbGGmDs7fKQfHPtSb4mCcDVD24qi
	k2T+uonbBi90gKojerHY+J89BccQQemZk6v1VNLI7tDt1dtpSMX6j8DynFb5X7M7
X-Gm-Gg: AR+sD12znEL9mUsVvMPizLKjCG8mE4Jrh3HoQl9UAmUxSW5wAOOrhAS9L3sym68iA7x
	iBuoPanbZxtCdabbTVaX5ml0uriAi0cBbuIyychPVboKgEAu3rwzIaXt9gLKEs2X0taZpPsIXue
	ULWfEmTF48cT9nkWv48NlyskGq9C3mgx6gA72qM9AlQr56zrBSTRxiL12yN9Rig1aTBofETiHwO
	dRytQGdjBI5NcydlxPV+aq8YD6vuArmD0Ibxtz3/HFLLra4mbKJED26krxU5kTBDxGllplc7ldu
	/NF+H7XdM7hmyVmujJ84Cmj+06EHBhJ6L67/x5GPWWSL+iNhKkxF562LtFDMgdBTNoJsUtC3aPA
	e4BUb7O0vkYLSk0ZG4T5oX3KQs5fuY1aM2vJCUq0GZXtBrfEPQ7pN977tSp7JrEr3bGwsxw84a7
	THylz5ag==
X-Received: by 2002:a17:90b:388e:b0:38e:bfe:81e3 with SMTP id 98e67ed59e1d1-38ec6495a20mr1338287a91.8.1784778755164;
        Wed, 22 Jul 2026 20:52:35 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/21] binfmt_misc: require an absolute interpreter
 path with 'C'
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-1-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-1-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872729.254289.514226158931792401.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 16:13:43 +0200, Christian Brauner <brauner@kernel.org> wrote:
> A 'C' entry computes the credentials from the matched binary instead of
> from the interpreter. So a set*id binary hands its credentials to
> whatever the entry names as its interpreter.
> 
> Without 'F' that interpreter is not opened until the exec happens and
> open_exec() resolves the path relative to the current working directory.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
