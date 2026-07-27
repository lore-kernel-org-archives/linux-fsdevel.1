Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996D3FB07F;
	Mon, 27 Jul 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156402; cv=none; b=EP9ikZm1EvuKLrl+rFZtlwUgj5pPAaryzzVU8JF+zUkqFUTV3wfRm9k5DSF3qFrp8laxooL949CuAHaimzCc4OQN3T3BUOTJt5a7jNooAwXvO92ag5S+TBTW33SzZ7my7d0oUgdYV0AisFWbmubtigEgFUdVZrVSizxh4oCf3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156402; c=relaxed/simple;
	bh=+A/TR6zl48rSZ05dBnTHE7c/MGTwhOrLP7sTtv8R5Io=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pVB1cMGbNYgAayhQWwRLDfTcAnGnHtAAuyYWGny1I2BbYuQqj+hiHZVTvCoSOU2czLRHymT7b7fDwqHmq/DUzh12rFJDxGgEGZmm7TVC9VtAeDmbiTn9X+k5lw8uJmtEmrQzHphz+50kUlOatLCQ3pDvX0f3uCbVz1OSvvCruO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPPO8ayJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPPO8ayJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF9C1F000E9;
	Mon, 27 Jul 2026 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785156401;
	bh=fVsYkwWYs1exNAhk7nwHtJENFxQWL6IfrmepDE9ribQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=fPPO8ayJmTbqQpZereTaMEbtXOtKx9ceaYtyzeLUX1AottvO3AHb6ya4OuzdajjgE
	 6drjolZwTcw8xJoBSxbiE8s0+egNYsLTRllygW9UAuaYue6sGeuB2MJCbWmWCGKooB
	 6j5hyWRwEnkzXPMfAHVp0B83is992Y44SSDIgYpIItOfXBdP5ZDgPBfON+DT/mZVUB
	 MH/5CdAVdyiFf+vRw+9j0CjDqUUifOgUiqDWhXH9VesUjnKq1pZH/EgIrRCMYn2Lsh
	 3veA5yW/EEVIcG9HlSodwzpoq9AAmEWmDdWcj4C50WxVtFC5U37fdxSuQOg28BHsBC
	 KB2iWsZ/+Czeg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 14:46:32 +0200
Message-Id: <DK9D4LAND3I8.1CXI8473PG88M@kernel.org>
Subject: Re: [PATCH 3/5] rust: sync: add WaitQueue infrastructure
Cc: <gregkh@linuxfoundation.org>, <arve@android.com>, <tkjos@android.com>,
 <brauner@kernel.org>, <cmllamas@google.com>, <aliceryhl@google.com>,
 <boqun@kernel.org>, <lyude@redhat.com>, <daniel.almeida@collabora.com>,
 <work@onurozkan.dev>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <kprateek.nayak@amd.com>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
 <longman@redhat.com>, <viro@zeniv.linux.org.uk>, <jack@suse.cz>,
 <tj@kernel.org>, <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260726223613.1242940-1-dakr@kernel.org>
 <20260726223613.1242940-4-dakr@kernel.org>
 <DK9C6KISAMX3.H10297T645RT@garyguo.net>
In-Reply-To: <DK9C6KISAMX3.H10297T645RT@garyguo.net>

On Mon Jul 27, 2026 at 2:02 PM CEST, Gary Guo wrote:
>> @@ -0,0 +1,388 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Wait queue.
>> +//!
>> +//! C header: [`include/linux/wait.h`](srctree/include/linux/wait.h)
>> +
>> +use super::LockClassKey;
>> +use crate::{
>> +    prelude::*,
>> +    str::CStr,
>> +    task::{
>> +        self,
>> +        TASK_INTERRUPTIBLE,
>> +        TASK_NORMAL,
>> +        TASK_UNINTERRUPTIBLE, //
>
> Hmm, I am not sure why we are exposing these as constants from kernel::ta=
sk.
> Regardless, Given that you're using them for bindings, you should probabl=
y get
> them from bindings::TASK_* instead.

See commit f090f0d0eea9 ("rust: sync: update integer types in CondVar");
personally I don't mind either way.
