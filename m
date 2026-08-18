Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7144657F5
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053136; cv=pass; b=XARP6D0NsWZjZDYgh0dGr2jmACZfz9nkHFGAeHvN0UC+BmZZNi5JkFxq96lbp5hGe8CFGJPmivKa1qYaV5nSDAjAXqcXbrrQb1bkGGS67IOTDAkQIDjA5TVot0z9LOa1u7FlCKa4ACzH641D9No+NL1B93Od0MpalwPhDe6RAxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053136; c=relaxed/simple;
	bh=R5o16+Omcz53a7Kx4ZfW7KXrNOIiI548XNd9wpNEOgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDm4kZIjTxjKQypbuWejyirUS6PQgf51AlcmxRFWrBMZX70FrHYQHWU7oOvj5yJXFGUwbUaVpdVMjiKPjOkpeAEjfAWhI01iVHap7PRskPKFeaIaMHKENItZdfQxo+73DefubCOM3yOFefSgVFk7/U4PH/wMUtLmeAVTs3hXfAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EI7GyTpO; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EI7GyTpO"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52b4e988c77so29159441cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 04:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787053133; cv=none;
        d=google.com; s=arc-20260327;
        b=VEw/pIpfx9H4wTfecp++rOiIZYwyIyQ64HmzgPGRx307bCytPqs4oG66UvskD7OXo7
         rdxpvykjCVepNNiJY79zShjPVxJS+UOTxMMHGAWPk9IemWB42+YYnVPpZQJLNBBW3kv4
         xdtpd61iusph/QkPb05fjnh4fo+h2SCYN3HBXKdkKtIuyaaGhmFmG2VKvKLtzhGzVY19
         8toqGdh9QdFmHNrHeKDng9SmILPen4WGe5Arrjrybayrdn2c0FeOe9oKUaZjrX7AkYjQ
         YbZfVzG1ojAuGcVOmKazvlfvfTUflzZ+wyBBYLn6eL2H9+1GzXovLfuztBPDIEkC+VRy
         HOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IKEkIrKVQR0ZN9IVyQ5hY25xXRDuaWv/xBwod1rhWEQ=;
        fh=oQ4tGDHQCYJPld/APJQSuZFLADJy0icx0l3OMZvS7Ag=;
        b=KxU1vfWSM7qKLTNYzTI6werIyUveW5E5L4iEwsId02VgmS5ehE4fPqLP7U5iweIs8y
         q3kQcstOEyU/s/+yRKScpJqvuAH9BgutI0YH1Rr+CmzzWPAMsL5eEk6wQy1idd5cXfsc
         wOIA6VADxUGyZKBXApDJS80/23OBb1dvrbH9H0gO56nk4rWcYpu5XcAZr9dWSaYwuVkI
         ztADYh4AkXSSBaPtei9S44ALnDJg1NMRi4gFO1OD8lMzq3fkmy7aXMThDtQcuXVIldIW
         zFAzWhKhHd0cdWIf6Ux3IJeG3Tk96emwESeFmAhpkBDPuHkWGnL5JD8kUjuIkHh+jcRP
         ezvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787053133; x=1787657933; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IKEkIrKVQR0ZN9IVyQ5hY25xXRDuaWv/xBwod1rhWEQ=;
        b=EI7GyTpOVHPUVzLoI5SVwYBc2+Q2SAV/rQi+J04bOsaY503EGBYx9SXdinFkqaYqaD
         nODI559274VmVo4XkV0x2bWF1NE6Ki0yrepjm8X/yU13ZCExYSgiijJHTUiaxlKeSdf7
         McqVTVld+bvd8lMWakbpuRHGfw7sd4P7p03K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787053133; x=1787657933;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IKEkIrKVQR0ZN9IVyQ5hY25xXRDuaWv/xBwod1rhWEQ=;
        b=fYnkWHzLL4hdTncO20gk4wadD5/vBnLHOjpREOogluXGga5Fmxm9Xbi4Hn+PHh+Cm8
         pZ/6WH4098GgnZPjF01hCA2iFlp2it/9Ct1lXdfkszGeTxiSIGMKDNgnkFYXBwqESD/I
         NPiekSaUpPyIpr54qtD8ksyPwqyPXRMzNHXpROK7HqIJwXknW3MY0Zz/ZkvLHOeJqYC+
         ukPwMqLOu+OfaZhhvHnKlWi667s/VVL1IwK88SQ+CrONL/4uyyvZpn08PVuVR+VP7RmP
         HvDjOhQyuT45HcpDmG+CB18KaOVR7Vbjadia1QD0L0isHj0Ly0DBPJsBna22jtRQ2KnO
         5fsA==
X-Gm-Message-State: AOJu0Yz8xhlMBxFq0iUDSXgXGvMrHsgkhJhtmbyrMigmLyzxGiKjn3Ls
	9oUxn1E/jyQXbyvaZBcFCQO6nDXCQ+MjR9JqV+esmeah/Lfea8izdLbCpvySYR5oazn7rtMoWx/
	mbH3rKBZNztT2YQQQe7bZWFzmXncUygMHdZy0/qH02A==
X-Gm-Gg: AR+sD11De++PF9hnfPivaOgnLoz96BimJ7tXhJuFnSMyiRPWtWUO0s1RI479AEUD3D1
	bIKMPxc7hHNPJMWeRilRIyHxX3AXvXQoOlvOMTXTwlV3itHcX+YPWKo4cKERQFccxj5hSOcGexB
	jZq3ixcX7/SprCVA9a2058b2Sv5SS12z6AKWd+ZLiQevLqbo1p0tXdvMRDUauY6IVG80JllHutF
	Ganb7EkdqHSrVRXNIUVV7nzudUh2XGxnIzgunNU4i/3DP8ylxY+kTv+oS0R9xC7Ea9PRdVHddmF
	lV3Vc3c6gGRgsy8Ao8XglTaX4xz9sNI+pwQej5vJr/+gWHV5hQMjKZfkMcR7lCm+MDf1YMqcd6j
	PP4THtUFp+vk=
X-Received: by 2002:ac8:5d56:0:b0:52d:82bf:d4cf with SMTP id
 d75a77b69052e-52d85423d44mr330702361cf.16.1787053133550; Tue, 18 Aug 2026
 04:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727210718.125872-1-psalian@google.com>
In-Reply-To: <20260727210718.125872-1-psalian@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 13:38:42 +0200
X-Gm-Features: AcwNN1XewOXnh0aWSTVRImoi3l7UFUMEHcPRuIjYoS02ZE13JAWqCypgXDea8Go
Message-ID: <CAJfpegvtp3L3FuYd8v1Ox0nZ-fb632jy+_M_+YyBWpMQGJAXug@mail.gmail.com>
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
To: Punit Salian <psalian@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

[Cc:  Tom Lendacky + lists]

On Mon, 27 Jul 2026 at 23:07, Punit Salian <psalian@google.com> wrote:
>
> In confidential computing guest environments (such as AMD SEV-SNP or
> Intel TDX), direct memory access (DAX) mappings between the guest kernel
> and host-backed FUSE/virtiofs shared memory regions must be accessed
> using shared (decrypted) page protections.
>
> Modify fuse_dax_mmap() to apply pgprot_decrypted() to vma->vm_page_prot
> when establishing FUSE DAX memory mappings. This ensures guest page
> table entries for shared DAX buffers are explicitly marked as decrypted,
> preventing memory encryption faults when accessing host-shared DAX memory.
>
> Signed-off-by: Punit Salian <psalian@google.com>
> ---
>  fs/fuse/dax.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index a15c464c8d19..00e316a7f805 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -826,6 +826,7 @@ int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
>         file_accessed(file);
>         vma->vm_ops = &fuse_dax_vm_ops;
>         vm_flags_set(vma, VM_MIXEDMAP | VM_HUGEPAGE);
> +       vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>
>         return 0;
>  }
> --

Needs review from someone understanding this technology.

Thanks,
Miklos
