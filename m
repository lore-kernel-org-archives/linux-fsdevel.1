Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793054553;
	b=N21/nc9+TqB59Q2w3DmyXvGNxwVEYpmiZRNbBnUBWiGKBNWwXRzI6HYdp7rIx52t7VqD
	 jeHXCrp6SV5uQE7O8TPndyo16559eVVeqVx2Qqp0xZBNEM65i17iW1OZzZB3q+OdHg4F8
	 ObBVdoJbY2KD7znlG8Tk1FC2y01xMHZoftepv3YAmv7JnqZIH78d5PUXxOv2rdUNdKyL3
	 2+kRPNvnwJEvJXbG3R3olF5ofm99u0zTpyK+K5SIM5Z2l7Wx63XJrFFpoxRlDL2uBxIBU
	 6lnN5hvSTdNcfTObidJf5+2oahjd6LcDXo/13etuaYVaUmeBWdj3/QZWQ19ozIjAdCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
	b=0eQW+ItUCP6LKGpD2vtaELoh76WztZrjipmqyFLzS1y33IeIw70CDPFde8Fh9n56KaK4
	 fUuD9UeH9hEhRcv2ArkX7LhoZ9DLOC7SIDoahYF4xCoeQw+PgwWrSL90YwM5FoK5Dq8mB
	 ZhBPIC7DiWGMw3USIn/FcksJNFDT8wHtAmNKHDnQFd6iqmgiQcS0Pbyya6HglJ59jN9zz
	 e2MY449js4IfaYDKUi7flf46pu5OXScQYlhguy/2kMc8wIGyPc1Tuas5RXTk2HCE8/28q
	 S98M+ljpYEMZo02lJwIs3KEYLkq5huVH2RdMsV8mLTkredRjRe1I60DWFCZTuw89S7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ho8+h6Mf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A5606A326
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 22:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A9A5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ho8+h6Mf
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so490747066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 15:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793054552; cv=none;
        d=google.com; s=arc-20260327;
        b=sD5kKn5sg/tGiAf7J65zNddKh7RMCPhna6Gc1g2IFDf9xBgDcy/RcDAszdPeIGhAkl
         9+MlXW1NYZiMtSbOGqPV75AMwi0WmIuFX76ytGq5c8bdoj88w3SAiReHzWkDjo1uIFtH
         6k3N3YgF2/3sCI3QIFWWrC+0w+ZBoKcK/+K/98Jg7oCf/uDlz4nQhhgIRSqSC8w8+/Yg
         vngaWjYFuVVO9D2rOf1v9VJqg6baoGnJqkGfT3Xz3veXBop3ojykJAZLLswklSuYPwKs
         YgjDLX9cSh4SKJHJne31YvCLXBOsGdHVOX428U7uuTm0UfImZ6JV0WxVjNIKMhTBEFv+
         TIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        fh=lHIWs0nA4ba2rBLFY+V8xXyxSzBGZ3MOp5AjQzozhtY=;
        b=VYgKUDsm1wGLkX4KSYGloOcg4HMhf7aczP9HZ5NvN0xuXYMwBcAXVaLnd9mkKYESpN
         1+2K8884+A2DLEcXH2KwSnL+anY1Vkg0n7XA6hDf89Q7UQ7qVybI68V86Ix15gumLP3v
         wlYcxuITHkcuhhsoE1RzZF2IIQj4t5e68aebkTPDrw7Z4MMx5eof2J1Vdz1P8DDtl91i
         MCllvJfiQEGTUz6svRHAiCOTU+/vGL0c25apPOrdHkQNNEJ9cfrckerEdbVoDdyxAutS
         uzWQPzRbx4eHT1tFlrcoxeniUt8t/rAllhjeeatpcrW6sH/PRctW2BO+mRwZhTBFuqhf
         8xqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793054552; x=1793659352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        b=Ho8+h6MfzfNYBnYXWcB1Csn7RkH5FDAzc185C3faxOFFVI5Ip8rPZvUVVS9a7mPz36
         24gi8R8N3yA+KvfwmaRReqCQoQsNezGiPP1Bp7GiihlQBrxNS9eCbaY93g0l7+W+vIC0
         voQ2Heu+uMnZMYR6TuMnUotBhMhKn8fZO7YhZJ/VGMtSyWbiopW5EZJQ5vT2/6dOt2QP
         h6y7P/JEcSU5qhjYmxEPNqjJ3oooD2zuidI/sWorRbLSpg0w4GfbG7VlXLnZBZNxscre
         60kjozBonZXdnmTiD0g6qsMUd7kqNlcLdjiG7bhzjYU1/2dfEHHIUzSVvBAgpzwQCCET
         IiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054552; x=1793659352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        b=y6QfBJvklyNLi6MI+wLbO1gnuWP+vN5R7iZAiOugDDN1z6apGGShrBcdcWD1c8ZbNM
         qgC5IeDBW92EBBTK7eb7BVXsGP4Aq07pWFh6UYh5yYV2RPH0L7FSNiTv8Cn9EhaR6qO5
         YBa9nvWybnTCL0qrp5ZkD8XlmQmFl7vMk5W/KSQm2si+uclPK/qfpYEFgWRk9vBawNmu
         cUXC7nroMTdsJ+3oZ6u2BexhioVsYAgOUYVVmZfhUDWddvzyMVQYAHHTEz2qzTvAX2vu
         2lOjxwrx6Zz0JzrF2xcoeicZL5CsBtufjps3E/SgCONkg/yQ0i0u1+SuemtkXg870gAd
         q6nQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgIY0w5k2v2LDpbIzZVsYvIe/wcIuxS1CSnjEs4kcWPIVZn8gT7QwB++y1DCHituu7ROnWx3cTxcNMWqV9@vger.kernel.org
X-Gm-Message-State: AFq9FYIw1cTqwrzYtu6Tn848PGWH3jgsV/ggpYCQeDGqm0DJIPmlKVC+
	qRWgojtfS7CzJJVEzoN7zGQdqClYOsU/V33uvbOmfqj4m1zxrqBnI4NfEAbEdK9c5dzRKJnhJp4
	VbhxB52OaSMjwGrrvIEYM4OJA492fkUz3Q/u4qa1x
X-Gm-Gg: AYBFou0bDtQyP6HuX7QPd13/bqET3fzjKQY9yxDFiWRxEyC5z3ZayDEK+eoEmIJe0Ou
	hynlHd+8SrPigmb0+S0RfF3QPKez0gqomenDzpnGZ3gJ/6841B00dfC8oF32CAZPXXzPRInG/B7
	0iL2e/ndAzZiVZUsO66EwQhXTl7c08XTK/Sk9w3FRC40QbhebI4hxkz4sVu7eCVE/7bmWfvmLhQ
	XjmXb/g244di80j7wAIEc2+vYzFd/8DcApqujlT1uVI2PcuFn50LWla2QLyjiWGrXaIawTuhwJm
	2qo4hIq4rPRjQ3Bkpd2OVA6UWnDReycxq6Hz0l+JpDrl60DxPMM9Fi4kcGBTT6C4AzHZejXFFbn
	AhDbrwrNUIIzAMu6FQWyS+mSEZJuGtXDP5IyZstDRZFi1bXT508DxLx/uEV/AMu9ujiQqjMQR14
	0b9G6Y8bRbP7i+lD5ixUnUHbuVOSYqrfywl+Gsm/6WspHbGpZiSv4J34rJmD5rh6USKCgh1yiWx
	J9Fi6U1
X-Received: by 2002:a17:906:4fcb:b0:c46:8733:642b with SMTP id
 a640c23a62f3a-c46bdeba20dmr991156866b.43.1793054551213; Mon, 26 Oct 2026
 15:42:31 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-9-jthoughton@google.com> <da7bb91d95914febc9b2b981c0b8292022d6f6437ecb68ed2b717f0f4a3a04c2@mail.kernel.org>
In-Reply-To: <da7bb91d95914febc9b2b981c0b8292022d6f6437ecb68ed2b717f0f4a3a04c2@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 15:41:52 -0700
X-Gm-Features: AclHuK9NQf_DmtP280VFWB18VLK39ZMzdxZm9Qsh_-4Snm7U1eOCkiznChHcSHY
Message-ID: <CADrL8HXA3KVX9agtcExpPuaBLC-zAEWx6QgsRnQ6+cb4AZZrFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] uaccess: Refuse and warn on __copy_from_user_inatomic()
 without an mm
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > uaccess: Refuse and warn on __copy_from_user_inatomic() without an mm
>
> TL;DR: Commit message only: it names kvm_read_guest_atomic(), which no lo=
nger
> exists in this tree; the review suggests kvm_vcpu_read_guest_atomic() ins=
tead.
>
> >     uaccess: Refuse and warn on __copy_from_user_inatomic() without an =
mm
> >
> >     __copy_from_user_inatomic() never called should_fail_usercopy(), so=
 the
> >     NULL current->mm check added to uaccess_should_fail() does not cove=
r it.
> >     It is used e.g. by KVM's kvm_read_guest_atomic(), by several
> >     architectures' perf callchain and stack trace code, and by the gene=
ric
> >     copy_from_user_inatomic_nontemporal().
> >
> >     Split the NULL mm check out of uaccess_should_fail() into
> >     uaccess_without_mm(), and use it in __copy_from_user_inatomic() to =
warn
> >     and refuse the copy.
> >
> >     Don't use uaccess_should_fail() there, as that would also start inj=
ecting
> >     failures into __copy_from_user_inatomic(), which some callers don't
> >     expect to fail in practice, e.g. __wp_page_copy_user() warns if the=
 copy
> >     fails twice.
> >
> >     copy_from_user_nofault() already fails quietly when current->mm is =
NULL,
> >     and the generic user stack unwinding entry points (perf_callchain()=
,
> >     get_perf_callchain() and stack_trace_save_user()) only unwind the u=
ser
> >     stack of a user task with an mm, so neither is affected.
> >
> >     Signed-off-by: James Houghton <jthoughton@google.com>
>
> The changelog names kvm_read_guest_atomic() as a user of
> __copy_from_user_inatomic(), but that function no longer exists in this t=
ree.
> It was removed by commit ef82eddc0e31 ("KVM: Remove kvm_read_guest_atomic=
()").
>
> The KVM user is now kvm_vcpu_read_guest_atomic() in virt/kvm/kvm_main.c,
> which calls the static __kvm_read_guest_atomic():
>
>     static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_=
t gfn,
>                                        void *data, int offset, unsigned l=
ong len)
>     {
>         ...
>         pagefault_disable();
>         r =3D __copy_from_user_inatomic(data, (void __user *)addr + offse=
t, len);
>         pagefault_enable();
>
> A grep for kvm_read_guest_atomic only finds __kvm_read_guest_atomic() and
> kvm_vcpu_read_guest_atomic().
>
> Could the changelog say kvm_vcpu_read_guest_atomic() instead?

Yes, that is correct. I've applied this fix in v2.
