Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706E328610
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860141; cv=pass; b=DeXovror37iotG7FXNxvFoB1bqxCxDStji91rEhUzABlTFgQeSQgXJn5QXkNvLZYNfYHLqXiVMGklNzH8IoOvNrNOZb01UzUu4Ao1irK2do2eIhvbnI+dEDekBKbtXY37gWw16koLacN8jtMYnt7/Aj2eEkDlAPOgTWpgWZKzHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860141; c=relaxed/simple;
	bh=U6P6GVenUM7M1V04XROjUEwO48BnDDCBFpmQQ3vqOPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5K0DolwbhnoOzCUqjVkwXzoEoYJhRjg2kKlhVUPlc6xSJl2t0sg+ryZOq4PhsTlFmBcmkelmQm3YmsgPCNgvFyQ8xlDJUb1vr7rhJZABfy1mMtcjtY1ZH5ZqYg9B0k70t3y1PWM8/mTdS6VhE4+O/eebIQKr3YG2+KUo+GpARo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwwkbQXU; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwwkbQXU"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-13b2b08a553so38608c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 15:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782860139; cv=none;
        d=google.com; s=arc-20260327;
        b=qHKx69Zws23+Sa592ikE+SQ3jOiorziX+WAZM0pNkpXJFLodCMKuoV42bSkei23Pl5
         fOpmP+Mz4/3Qp3znKmQI7O7OaF/hQEvbAVhUdwMY3+EZ7gLVgIgeypURGtzfKou1VhxD
         Y8DSMyl96oGDALT9V2i9ELVqYfVE3lRvGeQbgCUHGFmcnWZJGQQU2aG/r/qY1zV0gMHu
         mRxAHnSNEylde8UqYyMRt4tDueoDWYJIywmXXvcNMCAxrkp4owAuCCYNMo1jnNLYR0zv
         8wFAh8lli4oNMxUYeT1zPt7zL++0ei7ShCYkLVxWDdVrqRoVX59Bgy1EXQnKRiFh3ehJ
         dWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0ufRs7jbz+7zNErx/AfaA1flmtddekdRBnIktmT56h4=;
        fh=KM1UpChfce/s4bk76w2xzHGJdTHmR3A8UsPS2J8kUS8=;
        b=fckbRNI0K1vxLDUDr8yl5s3W7efBHlGXO6hWpOJ4wd3tDy4t5l1tnAJTQrvtEv1Jui
         Lk9e8cMJUguhvNpM2AfFEWaPvempaLT/mNHmmJbYNCgOO/jf2u4mlXS+eURqhOSSk/Jn
         QCPoEYi0N4hnIBqgcTHCg/dXH/YmQtV7jBg6JdmOToWo0ZhYtENxVopexGZpgoKrdmHI
         8+xGljyJ7MzlbgTVaDh+TRn3Fz5XIX+9VuXpgueI6ya7mHN5Yk1wiA1iwPYVD9AUcecn
         iCDhS1UQZLRbZo4q6H90ed7gY8z2Ce0rtTXUJB3vfZFbtFAGFE62OVwW1MoekvOSnib0
         mdow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860139; x=1783464939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ufRs7jbz+7zNErx/AfaA1flmtddekdRBnIktmT56h4=;
        b=jwwkbQXU4plCk5JPPjsZMQJtgmoKYDljp3tD7DbdHQlzG3IdLItQLVD2HTaoTSX55P
         jjqI+LGZESKqQ7OEkZGeigyS5L0axr7d48WbZ2n5SS0H4Jtz65T3A4sWT/hBQFlsH1k1
         rBbzdIYQqAS6kPeWMZ3o25AJcCVdjAodAIz2nN5H7fV2+vi3V/Vte4RsMnojLSC1XbT+
         kIVnEFn+UzatYa2ex41llL4cu7vfsVyQOLmPygrMNhe0rMoNp5adxqrRi+x4OYbUp9T0
         UEPm3O/cMZ8TmORoGwiAt6pebfDoHJ8yleHmv+VD7iC2odlLbEA2cA7VTFc9pwEprfLx
         kafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860139; x=1783464939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ufRs7jbz+7zNErx/AfaA1flmtddekdRBnIktmT56h4=;
        b=cVQhB8/6IVXPk3iTxhT+C3l3Jhu5tP6YQ+0kusbZaXnCyilztpVjTfACKKQAUT3KyJ
         kg6xGKu8QqLlkrd9eG6dk/a9cMhb5EIsWKpgvpVsckdC52NgE3T9GI0obUsHq/W7j2HT
         ejpenyDbbVbcLTGSCD4ql1w6qxI5BWRnlmGypu8z2bDUGWp7WxPIUS42wuslOtPokKxT
         LVq6bXoecLn8SOGzK4R9qUaGdKIQh+HldN9Wlv+lblhMX6+kzReJgzYf1TdboZsDOwcK
         goEh3R9Vl1h5uUTbIYgwtM8pbEQkIoAjy2FKUym0LYVVjZBwhWy/O3Rxz0s5FGnv5F+c
         tgUg==
X-Forwarded-Encrypted: i=1; AFNElJ8sbs4PyJ2JEsc/WiH3lT2ldZnKfkE6AaZOiyFtT/EgygkmBweOEV5KUdvh/OAZf0/SpXLvdGeANble0ruT@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMraLkYm0K8FTpfC8wphPHxiUWxuBN325+fxTBmW445vlXqQl
	jaMNm8PqNZ28fpsN6yOSz30NwSlTUf48b24GQFm2hIOsDj8ahDUsmkJ/uOEh7TEcCJQaS0O4vrN
	gQLjDknjYoDjPdf6VFmI+KPxl1ZY+Z0Ps+mu2tqBp
X-Gm-Gg: AfdE7ckiWx+JiojDKbYlN7eBcNw0J6trJAxRN37OdDAlgx/MJIN8d8apMUI/xlCU4Zw
	CvTYvRiTq4KwjSvO3eSKM+T5UNgfdMwGZZFWGlTaCm7/5at/0mRMN3jWKyI3KDp4TGWuK5WwPYg
	LVFwQoGTm0A/8ZslPsUHGkiCeBB+b/Fozs+UI4BYhcW2Nb2QVRHl2nMWi2EGTc8DtHF6qVlgjKD
	PcaPR5vMNTCG5g4CUVMyUsUuYeia62lMJPlgtJDCilpxZF+rV46zzOeXGUBksuoq1CiDTDd
X-Received: by 2002:a05:7022:60a:b0:139:ed5d:1b5a with SMTP id
 a92af1059eb24-13b2a1c0f41mr3645093c88.40.1782860138109; Tue, 30 Jun 2026
 15:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625054946.73445-1-duanchenghao@kylinos.cn>
 <20260625054946.73445-2-duanchenghao@kylinos.cn> <2vxzfr2bkn0j.fsf@kernel.org>
 <20260629100621.GA215869@chenghao-pc>
In-Reply-To: <20260629100621.GA215869@chenghao-pc>
From: David Matlack <dmatlack@google.com>
Date: Tue, 30 Jun 2026 15:55:11 -0700
X-Gm-Features: AVVi8CdC-YicerQYwyKKogj1zQs5YRNCTCvCtXWkU5DiVwwhFHMSMIyXZ1dV4nA
Message-ID: <CALzav=c+RzWpJTrpsdwnHUT=EZCGv=FGtmDq9ipDE7jNuWNX0g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] eventfd: luo: luo support for preserving eventfd
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: Pratyush Yadav <pratyush@kernel.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, pasha.tatashin@soleen.com, 
	linux-kernel@vger.kernel.org, rppt@kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 3:06=E2=80=AFAM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> On Thu, Jun 25, 2026 at 11:06:04AM +0200, Pratyush Yadav wrote:
> > On Thu, Jun 25 2026, Chenghao Duan wrote:
> >
> > > This patch adds support for preserving eventfd file descriptors acros=
s
> > > kexec live updates using the Live Update Orchestrator (LUO) framework=
.
> > > Userspace applications using eventfd for event notification can now
> > > maintain their state across kernel updates.
> > >
> > > Preserved State:
> > > The following properties of the eventfd are preserved across kexec:
> > > - Counter Value: The current 64-bit counter value, including any pend=
ing
> > >   events that have been signaled but not yet consumed by readers.
> > > - File Flags: The creation flags (EFD_SEMAPHORE, EFD_CLOEXEC, EFD_NON=
BLOCK)
> > >   are preserved.
> > >
> > > Non-Preserved State:
> > > - File Descriptor Number: The eventfd will be assigned a new fd numbe=
r
> > >   in the target process after restore.
> > > - Wait Queue State: Any processes blocked on read() operations will b=
e
> > >   woken up and need to re-establish their blocking state.
> > > - All other internal state is reset to default.
> > >
> > > Changes:
> > > - fs/eventfd.c: Add eventfd_luo_get_state() to safely read eventfd st=
ate
> > >   (count and flags), and eventfd_create() helper function.
> > > - fs/eventfd_luo.c: New file implementing LUO file operations:
> > >   preserve, freeze, unpreserve, retrieve, and finish callbacks.
> > > - include/linux/eventfd.h: Export new functions.
> > > - include/linux/kho/abi/eventfd.h: Define the ABI contract with
> > >   eventfd_luo_ser structure for serialization.
> >
> > Why do you need to preserve this? Why don't you create a fresh one afte=
r
> > kexec? You just preserve the counter, which looks pretty much useless.
> > You can just as well open a new eventfd after kexec and set the counter
> > value if you care about it.
>
> Thank you very much for your review and suggestions.
>
> My original plan was to integrate KVM with eventfd. Eventfd serves as a
> critical notification mechanism between guest and host, and it is widely
> adopted in various scenarios such as networking, file systems, and
> interrupt handling.
>
> At present, however, I have only implemented the preserve and retrieve
> logic for eventfd, and the integration with KVM has not yet been
> completed.
>
> I have a question and would greatly appreciate your help with it.
> I have been closely following upstream developments for the liveupdate
> feature. As I understand it, liveupdate is primarily targeted at cloud
> virtual machine scenarios. The upstream community has completed the
> core framework for liveupdate and memfd, and ongoing discussions are
> focused on state preservation and restoration for VFIO and IOMMU.

Yes that's correct, but that work is to solve some very specific
problems for virtual machine scenarios:

 1. memfd preservation allows preserving guest memory and userspace
(e.g. VMM) state in-place across Live Update.
 2. VFIO/IOMMU preservation allows PCIe devices assigned to virtual
machines to keep running uninterrupted across Live Update.

I think this series is missing a description of the problem solved by
preserving eventfds. We don't want to preserve all types of fds just
for the sake of it. That will bloat the ABI (which will make
maintaining version compaitibility harder) without any gain.

>
> I would like to clarify the following points regarding upstream=E2=80=99s
> overall roadmap for the liveupdate feature:
> 1. What is the complete upstream plan for liveupdate?
> 2. What will the final deliverables look like once fully implemented?
> 3. Will any new kernel internal interfaces or dedicated userspace tools
> be introduced?
> 4.  Does the upstream community maintain an official TODO list tracking
> outstanding work items for liveupdate?

I don't think we have anything comprehensive but there is a ton of
work to be done if you are looking to help.

A good first step would be to attend the bi-weekly Hypervisor Live
Update meeting. See
https://lore.kernel.org/kexec/aiWW6ZwwalqQmVcB@google.com/. The next
one is on July 13th.
