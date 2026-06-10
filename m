Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8B3B5307
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125593; cv=pass; b=rKEpuBu1d2pXXBYJxP/IJLbP1XqCFWsIFjv24RvRpFZ5huTbMVmDrj4dq9iiRMTcJIuDjDI6rL1ymZsb+DbkL4OY6BHaJKJFRxkkhZ2QzSskvxBQKVN2AMyf4zqLzuQI5B+9tXuNy3PxiVe1CE1deaa2DxnzItrDROI97vGGhpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125593; c=relaxed/simple;
	bh=8SPk+9kPUL0DQYsfiU6U+3rhy9CmKqHE6O0qDp+jLZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLChmsJA4kcyFw7al/mMAUoa0g5mDpIPyVQIvFh1nN/rOdnBAKpj7FuhUwQGk3D3zUoZpRBXabt97yVLYSe4jRvIYm6F/Yz7QcRuczPGvuG4qTceVxwIjIh73NAxZJ4991wSIiowyyCNYj+KGos05rETICv1QSkh/Wg9Lb1Ut/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWOwKwlS; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWOwKwlS"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7ea16f090b4so91568507b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 14:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125589; cv=none;
        d=google.com; s=arc-20240605;
        b=K2v2MqnYzc+4eVxG5y4bYMNbwpWtjHGj3XUVWBgnJcogJFSOLr0RjIbt18fVNnPXsy
         147LwSfdpQqAx+HlgxVHDbSqItxAPel6mZbHbiHvOvNq3iV6kRobLXVmZZIZaKSsq5Zk
         29wKANJqpAU82C59fDd4XhBsAWF7YNrX3MfWUjkxnt2rfRpokC5R/apQRjSMdgqCS1U0
         a71U9ZRiPBiLME7oSy0aJybRy1tetVO1nZ57vYzkZjQ6/R8Gd0ncuaLgXtlUrNAQn5up
         BQjr7VoSNeXSKVw6LaYAY9xE4lly2+UM5CNjuW/1zBqvNga2D/2CYD7XUkjFx4i2XFiO
         OARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        fh=NNuki4cFAYSnXlSAsYLoeIgsaBAwo/55vXs69Yp2OU4=;
        b=Rj0uj9zwcjj24AiNE3Owg13Gg3AKDjKsSAgrUp2SnEbsMLBBxxfqfz/K+5TdgWLodW
         sRAFh5sZEAsGaiO+0pvL+Kz1f8SG3aTaYwfBtNG+VJazM3u66CSW7E28ydVMcDKJF8eI
         l+QsEFXqbPL8DsixXW1pFgO7e8Z5y4AR2gX/rHqDZXBgupEBFo5qAwMCGix6BR2oTU3v
         FvT5lsF8WKoMGVnt/PI31c5RdwmbMX2JL5AHfcBfvPdJzqjmZJnHZHApNhOqi0nVfyWQ
         NYoZjHmQi9gbAYp81AY1ThZHuyKQyTkm7VuenpfCX12MNoo33bgiihpWP9HtQtJvpyR+
         qgpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781125589; x=1781730389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=jWOwKwlStXwGgUAXfngBzfebepF/l+Iz4nUi1RY4ZFUDUceLV7UGbSPy/9QVHif4B8
         ZPz1O75qxMy7MzdeNnHDuLBQRANDqdgtNr4gpz1YjTbGBhWiD5oYWhkIc+R75zzFDCkO
         Meumk/PL2hxGiDTi1EoFtI5Rjo6hDtBgNs4khoSmLMvoD3D6m4fDnyZeU2/SVa8Rl3Nq
         Np8qgXa+5CNjzN4wJqgw9w2Dk9ZrR505dzxMLNWm5lQRAcJlwSMMAmfpaaFKXCI38Fkc
         kL00/uRMaIP0VLi90TJNN5Ph1pRYS3cFKXlldKH1fiRvxQ998TEqxSQ9HgBoZT5xJce+
         N+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125589; x=1781730389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=fA/ON1rzD8TYVDo4Z96MA+xmjN7cVw33EGxHrciGZVXzABmswJ4macp1guwm6CZmiL
         EHHsb8ShszA6aYHawcmIaSKBEbb2lzEeCEYEVjuddiTbMYFQ3J6JCpK6W3GdEJAEtCZP
         0dDhapWh7XIqINGFO3+woamx4RSwzYZeUVDhQJX9CNSd414ncoLx4NpIvuaTbcdlVBCZ
         Zysxo+E0cBHPCGjDwjz63e3QmRwOhTBx3iF/4dLXsZvZVem+wYWCwtrTyYRRorqOclac
         1+tNWZHNQG1FyOvdxy41ys6FE8ZopVnC7mdhlwhmqprPUGiBy77Y5Y8dxydXWE7knVTy
         iqAw==
X-Forwarded-Encrypted: i=1; AFNElJ+VhjRw/uzjf6uEKW7S9UIYKGpPEu4Vs46mifKuJdc+h561nO7XMo+Tr6TwnHr2eZdmWcEMH1gQDxQMCsci@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAGPQduFLwmiG4xrggGdpYumCDc0enjd1GKJ6StgfLQtutFbl
	gntsGpAWHs9sXZwl8d2mkQhoNg1orixTMObLuhFmjTwz2Bwiknag71rvLIKlo4KyH6yXWMBJ/Fu
	l0k7pme07vECm2pUK9D6IjamkGW7/dDI=
X-Gm-Gg: Acq92OG1KVx8qQqvvtPJql9Q1e01hBMIJEi3AFMu/ntMYTIiR8m2jcbJQsi+jpVlbx0
	L9UygreMgyqu8bhDCT5nPR3lTEnYbtSgkFDlDzx5x6M/GT9CrEJUMpzxr6cBa81+7R4GC411K/l
	0scWgg1BAkFnuQ8k/oIZ3D/eZuXEMHQOxUiPUTYNjVh1x1lLse3wG6uEEAVdObYeInMQnhdxr9L
	4jpV2PFBp2mMReCP9iSsZHYyAhNIyfA1teEKi8KCjtcSVC26SI8sdhz1ej9r5ILHc7wRRB0Oeb2
	PlWH/oR59qpARDZ6SC+RtRxeIg==
X-Received: by 2002:a05:690c:45c5:b0:7e9:ab56:3c99 with SMTP id
 00721157ae682-7ed0adbb616mr276188567b3.6.1781125589039; Wed, 10 Jun 2026
 14:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-4-kees@kernel.org>
 <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
In-Reply-To: <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
From: jim.cromie@gmail.com
Date: Wed, 10 Jun 2026 15:06:02 -0600
X-Gm-Features: AVVi8CcLXClq9Fijm8VjZF47hQWmos5q_iXrehNZDw9kSOby-E_cMxEQI0SK-hU
Message-ID: <CAJfuBxwRuT1K=rjPX+sdNyYurEJ=OjqbJaSa_S6JnY6yzTwTvQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Baron <jbaron@akamai.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 7:35=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 5/21/26 3:33 PM, Kees Cook wrote:
> > Using Coccinelle, rewrite every struct kernel_param_ops initializer tha=
t
> > sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> > for example:
> >
> > @@
> > declarer name DEFINE_KERNEL_PARAM_OPS;
> > identifier OPS;
> > expression SET, GET;
> > @@
> > - const struct kernel_param_ops OPS =3D {
> > -       .set =3D SET,
> > -       .get =3D GET,
> > - };
> > + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> >
> > Using the macro for initialization means future changes can manipulate
> > the struct layout and callback prototypes without having to change ever=
y
> > initializer.
>
> Nit: For consistency, I suggest also converting the few remaining
> kernel_param_ops instances that specify only .set and no .get, such as
> simdisk_param_ops_filename.
>
> --
> Thanks,
> Petr

for the dynamic-debug changes

Reviewed-by: Jim Cromie <jim.cromie@gmail.com>
