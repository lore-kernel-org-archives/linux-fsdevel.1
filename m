Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9B480DDE;
	Wed,  1 Jul 2026 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908138; cv=none; b=qSPq262bwKVC9rEVhOfi198/8G/iO8vdTiAxWlXuakRBoEj/DeSaLCh437GtMHzudrmHXsG5idlcI+mRL6rH+wNpWNlmhAXX9PM9xVyhPruZ2NhjczZ/MLgKh5GHgFjVnHg4p5hUqEvryAT/MQNkZNwy0UpumrvFBmI0iRFKZuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908138; c=relaxed/simple;
	bh=xBCL3//+5oy4OEYh/HJ4ziUc/xyA0SWCFf6uj6cQXls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hp9I4eADfdHc+DGYeX4+Vt/U7LTY5/bZbtkJP4Amzc/F1bD51H6QIrzBpIz76ail/O5rGVqkxls5iCHqJti3LlOLX4eR+nJlA9QhQtw8Jk+s/iwz9TuebuZ/ZhjovWM42+DC8wMXfgdfnUkWoLFDU/pMpgIH+byeQsz4P+Obwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osDeNUtR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osDeNUtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BC21F000E9;
	Wed,  1 Jul 2026 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782908137;
	bh=u9vIgqlb5PzQumgrF7Npwpto2QFwHQxQQBOLn0q9I5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=osDeNUtRA6PQBEPedTeWhJRfP/tCCXhUr/ZNMGCnyo+9SavtNZmLKrTe8+CU+dO7A
	 F9kMlvB8YKik/gZLC9IIa8adwsJYzBJC0q/lSL3cVKEr7qSkwPL3TWaSRyIi3NzP2V
	 fuzp+nC4O/o+xBUqfEICXBFStZpayvVK60JYi36RgD0xf3zjBfPdWxr5O3002pqbzF
	 GGd9CS4JQnCHv1oJ/YgD6zJTEswVMLsLojleLBtmsjwqOe9G0TxuPk+HfEXhTwBVc6
	 E4+de2OsNisZ1L5LtiS0REhRgR1PgRcOVr2+RX9UQiCCi2Xigd3Es3VXkZ4XHlc7be
	 XVVAjwgsMgXww==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Chenghao Duan <duanchenghao@kylinos.cn>,  Pratyush Yadav
 <pratyush@kernel.org>,  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  jack@suse.cz,  linux-fsdevel@vger.kernel.org,  pasha.tatashin@soleen.com,
  linux-kernel@vger.kernel.org,  rppt@kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  jianghaoran@kylinos.cn
Subject: Re: [PATCH v1 1/2] eventfd: luo: luo support for preserving eventfd
In-Reply-To: <CALzav=c+RzWpJTrpsdwnHUT=EZCGv=FGtmDq9ipDE7jNuWNX0g@mail.gmail.com>
	(David Matlack's message of "Tue, 30 Jun 2026 15:55:11 -0700")
References: <20260625054946.73445-1-duanchenghao@kylinos.cn>
	<20260625054946.73445-2-duanchenghao@kylinos.cn>
	<2vxzfr2bkn0j.fsf@kernel.org> <20260629100621.GA215869@chenghao-pc>
	<CALzav=c+RzWpJTrpsdwnHUT=EZCGv=FGtmDq9ipDE7jNuWNX0g@mail.gmail.com>
Date: Wed, 01 Jul 2026 14:15:33 +0200
Message-ID: <2vxztsqihpne.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30 2026, David Matlack wrote:

> On Mon, Jun 29, 2026 at 3:06=E2=80=AFAM Chenghao Duan <duanchenghao@kylin=
os.cn> wrote:
>>
>> On Thu, Jun 25, 2026 at 11:06:04AM +0200, Pratyush Yadav wrote:
>> > On Thu, Jun 25 2026, Chenghao Duan wrote:
>> >
>> > > This patch adds support for preserving eventfd file descriptors acro=
ss
>> > > kexec live updates using the Live Update Orchestrator (LUO) framewor=
k.
>> > > Userspace applications using eventfd for event notification can now
>> > > maintain their state across kernel updates.
>> > >
>> > > Preserved State:
>> > > The following properties of the eventfd are preserved across kexec:
>> > > - Counter Value: The current 64-bit counter value, including any pen=
ding
>> > >   events that have been signaled but not yet consumed by readers.
>> > > - File Flags: The creation flags (EFD_SEMAPHORE, EFD_CLOEXEC, EFD_NO=
NBLOCK)
>> > >   are preserved.
>> > >
>> > > Non-Preserved State:
>> > > - File Descriptor Number: The eventfd will be assigned a new fd numb=
er
>> > >   in the target process after restore.
>> > > - Wait Queue State: Any processes blocked on read() operations will =
be
>> > >   woken up and need to re-establish their blocking state.
>> > > - All other internal state is reset to default.
>> > >
>> > > Changes:
>> > > - fs/eventfd.c: Add eventfd_luo_get_state() to safely read eventfd s=
tate
>> > >   (count and flags), and eventfd_create() helper function.
>> > > - fs/eventfd_luo.c: New file implementing LUO file operations:
>> > >   preserve, freeze, unpreserve, retrieve, and finish callbacks.
>> > > - include/linux/eventfd.h: Export new functions.
>> > > - include/linux/kho/abi/eventfd.h: Define the ABI contract with
>> > >   eventfd_luo_ser structure for serialization.
>> >
>> > Why do you need to preserve this? Why don't you create a fresh one aft=
er
>> > kexec? You just preserve the counter, which looks pretty much useless.
>> > You can just as well open a new eventfd after kexec and set the counter
>> > value if you care about it.
>>
>> Thank you very much for your review and suggestions.
>>
>> My original plan was to integrate KVM with eventfd. Eventfd serves as a
>> critical notification mechanism between guest and host, and it is widely
>> adopted in various scenarios such as networking, file systems, and
>> interrupt handling.
>>
>> At present, however, I have only implemented the preserve and retrieve
>> logic for eventfd, and the integration with KVM has not yet been
>> completed.
>>
>> I have a question and would greatly appreciate your help with it.
>> I have been closely following upstream developments for the liveupdate
>> feature. As I understand it, liveupdate is primarily targeted at cloud
>> virtual machine scenarios. The upstream community has completed the
>> core framework for liveupdate and memfd, and ongoing discussions are
>> focused on state preservation and restoration for VFIO and IOMMU.
>
> Yes that's correct, but that work is to solve some very specific
> problems for virtual machine scenarios:
>
>  1. memfd preservation allows preserving guest memory and userspace
> (e.g. VMM) state in-place across Live Update.
>  2. VFIO/IOMMU preservation allows PCIe devices assigned to virtual
> machines to keep running uninterrupted across Live Update.
>
> I think this series is missing a description of the problem solved by
> preserving eventfds. We don't want to preserve all types of fds just
> for the sake of it. That will bloat the ABI (which will make
> maintaining version compaitibility harder) without any gain.

Yep. I'm not an expert on eventfd/KVM, but from my reading it looks like
it is only a signaling mechanism, and you can set it up fresh after a
live update, before you resume your VMs. There is no state here that
needs to be preserved.

Without a good reason on _why_ the eventfd state needs to be preserved,
I don't think this series should go forward.

>
>>
>> I would like to clarify the following points regarding upstream=E2=80=99s
>> overall roadmap for the liveupdate feature:
>> 1. What is the complete upstream plan for liveupdate?

I don't think there is a single "upstream plan" anywhere. But I reckon
the next few things I have seen people work on are adding support for
VFIO, PCI, IOMMU, guest_memfd, HugeTLB. Maybe TDX or other confidential
compute at some point, though I haven't seen anything concrete about
them.

>> 2. What will the final deliverables look like once fully implemented?
>> 3. Will any new kernel internal interfaces or dedicated userspace tools
>> be introduced?

Who knows, we add kernel interfaces when we see a need for it.

Systemd has recently gained support for live update.

>> 4.  Does the upstream community maintain an official TODO list tracking
>> outstanding work items for liveupdate?
>
> I don't think we have anything comprehensive but there is a ton of
> work to be done if you are looking to help.
>
> A good first step would be to attend the bi-weekly Hypervisor Live
> Update meeting. See
> https://lore.kernel.org/kexec/aiWW6ZwwalqQmVcB@google.com/. The next
> one is on July 13th.

+1

--=20
Regards,
Pratyush Yadav
