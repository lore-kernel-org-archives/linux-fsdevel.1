Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A34E13E1
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862371; cv=none; b=jkz6hnnIO2gbVvzp4TQ8TXt/lfYmd5E865nEgykzY8naesMmM5AfH0upQEBrlnfFKOYT5iDSqgg5xXZ3Gp/dCDL5i5CUvL37XOWIvPQR8Paj4MsBVtuwrgwLxQi3c8fiJ7rJlNKPLfQdV0sN0KaSdkMv7cWv0S5brUoDN2dQxio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862371; c=relaxed/simple;
	bh=L5wrXfBipBywywm0456CWR88hbdBnTem6i9VKKzZbCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmRdYqa3zpcqqC8feRBoIgRsRQDCMcYhe9IrxP4Io87Ss+x9OIveMmkJf7rZs1YKIxASIZAtg0AEVkU9IAPOp1u9kOlksMmv8mELgn0swFIvFJEOtUEHTNtd5o2NR0SRLdrltkRhPqZK4fdUUtd0rQmoALaoJjhytfcXaNqr35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net; spf=pass smtp.mailfrom=bobrowski.net; dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b=EhoumeQN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b="EhoumeQN"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso4188421a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1788862369; x=1789467169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GhA9ASZ5myh78peIx89yYob/fVYshdxCIaZiQ5E+/oU=;
        b=EhoumeQNM9iAJDSMeVJkE/BcO2sTN1IzlmeaIhrZLfQx2NqwD8XNV7PWFjFg44pc3T
         B33+JzVkfz9R3TuFgydm5ZifYn9Jd17vvVquToxz8YSgDIf+/TlAceanpQnXdBAi80+0
         V12JvE9RdSgL2e7hRNnMHcPDpMYN/0FwGadynWX/i+WmBhG+7XEMzsgHXlmpK7hVv7lD
         1etMUlVyR6lAqpHaFEqrwVa7tPQ9nfygN5TwUHKZaKYZQKuoJon+lcKvb5WcZVbfFnks
         9LWsjmkqN2BtMxhIst8T66CjigLvB1/6pDIKpUzydm061QNwNxvyTekwysIekcWiHgP+
         1eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862369; x=1789467169;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GhA9ASZ5myh78peIx89yYob/fVYshdxCIaZiQ5E+/oU=;
        b=ou51F66MY4/JApyrvK5ojWGchIsxTxVEb/YmUAzpQke6/QdAss6TIUXrlgOp9/0PfE
         9QiFHHcfZbgNjbMWj+YNBe+zQeA1vg5qbzuYvmlt5JWDG28M/3MoUXPU7Uc4won4h5iC
         2Y10cvS5oZ2lY29e1bknUBdJB80GrOq/ZnJ0pprQQJEnX9w4wZS1zN2M67UZ7f09Q0Td
         InISRBMzFI4bG8KHg6uWvjvklUQv5bpBuzcGAU9DlRo/MYR5We8QCTDPkOyLpUDQaBcT
         rGMz1nwfR1c0j08WeBs+DlkVq0kO925/BXjdJLdmn1n4U9FvXlH+nSnFZTLKE9T25okK
         zr7w==
X-Forwarded-Encrypted: i=1; AKwUvBz1k9q8aoUu3F61+Z4aKe5eh1EcaPezF7ilSbE2viZK85fQ3iRlW1mr8V1nh01ujAZbeqlkXPSmEPXc4NO2@vger.kernel.org
X-Gm-Message-State: AFuF++lBVgPDXyULLgKplpN1XAkSVpcvZRn7v3p9C2g7OZiOyobcVr+v
	uUx0dvm+KVcfdQ/5ukYZbqd0XgDLRuBXtT1hjTai+GkSiFUAOrM0/umF1hqsgQK/VtJE
X-Gm-Gg: AYBFou26u0zcKnh0VvTLLsQc6PR84rBwfM7lkPSdksDRO/kxh0yws8IKbIp92FuB+wB
	mIiSkC+gNTujOUFNGXTPWCTA59ub5V5q1fqkyTu4XF9yWuBl39wtjyzoM1JIJvqUGk4s4/EaOys
	q0MH7yF9o2ECQCvleckup74IUfGJtuDAE+Rre5pww6curKjifmNEGRaCC8KUxa5gb7h/a4eyN5w
	LpYlB72wxfywQVxm0pzC4g4MVh7Pcxd/QXI73oUdhrOJ6p4bABMKvLXDmPwNUY6fiWpKVKMq6jz
	3kWQDu3O8YN2gRsOvGNW5Y8rqt2img3hUPOxXWVC/yXZpgxGZcks78mtvS3G5dH+ukgMRJFCPCX
	3qUi/7N8LpPjNyyQqjXSCCQXJc55hfxMFSU4uP8AtCWly6EhAJnPiUZclAGPOZn8vY01B8nDlc0
	edxsxzlDlhvxOfXMG7MMqHip5jUZdvBFJY19Hpos8lUC2xdD3JQ4EexW84/BhHb6fNiz1YBbfut
	RzVrGxopXC9MwWAlcZFDnwWzCXuGcp8I8kRClVc
X-Received: by 2002:a17:90b:1e51:b0:399:ecd:d68d with SMTP id 98e67ed59e1d1-39b26260f7dmr38959127a91.22.1788862368635;
        Tue, 08 Sep 2026 03:12:48 -0700 (PDT)
Received: from lima-development (163-53-146-23.ip4.superloop.au. [163.53.146.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm35093697eec.19.2026.09.08.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:12:48 -0700 (PDT)
Date: Tue, 8 Sep 2026 20:12:33 +1000
From: Matt Bobrowski <matt@bobrowski.net>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@kernel.org,
	akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
	brauner@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	kpsingh@kernel.org, ljs@kernel.org, memxor@gmail.com,
	song@kernel.org, sun.jian.kdev@gmail.com, utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next v5 6/7] bpf: Mark linux_binprm->mm as
 trusted-or-null
Message-ID: <ap_fkWbaG5u7UH7y@lima-development>
References: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
 <20260907165220.52431-7-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907165220.52431-7-tasos.papagiannnis@gmail.com>

On Mon, Sep 07, 2026 at 07:52:19PM +0300, Anastasios Papagiannis wrote:
> Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
> can pass it to kfuncs after a NULL check.
> 
> The field is either NULL or points to a live mm_struct whenever BPF can
> access a linux_binprm. On successful exec, exec_mmap() installs the new
> address space before begin_new_exec() clears bprm->mm. The bprm_mm_init()
> error path clears the field before mmdrop(), and free_bprm() clears it
> before mmput(), as ensured by an earlier patch in this series.
> 
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>

Feel free to add RVB tags:

Reviewed-By: Matt Bobrowski <matt@bobrowski.net>

> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b5186e664aea..6799d9e080fc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6004,6 +6004,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
>  	struct inode *d_inode;
>  };
>  
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
> +	struct mm_struct *mm;
> +};
> +
>  BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
>  	struct sock *sk;
>  };
> @@ -6058,6 +6062,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>  {
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
>  
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
> -- 
> 2.55.0
> 
