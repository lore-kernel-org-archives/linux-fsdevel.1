Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F4358D00
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781366242; cv=none; b=iXUG2hTzbeb7EjM3VXUH6Yq2Hvc6mnam03Qy4idcrLwOvSjQ36Cx1WWtSnipceKDIX3SimTpY9ee5kS9YVviOMh9Nrw2KVbx3NgJ6vLuqs/riS3jYOxnf3MtWPhMG8ADQ1lVcv22YyCLAZBXRNTiMmYCeVV+QqlSNOy1OrJrHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781366242; c=relaxed/simple;
	bh=A6EogKgHjPqxJGDoOhmOpnHbpKqQXEoQYwG82srC3PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/LhJckPmc3Kr12KCu3sIA66lug6RYJE/z86DD1PHJuQN49iWmrhaQFRBhY33NaL0iwAYdW8WQOKxGXiZNgorLgcpaiAfdAJzSjODABxI3rM/duYEJWzNpG7zpqkxTdnWlmDF7uPExrnS6G/N0hlQNYQHy4LK5iHnqLWvX9HSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=giTr33i5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="giTr33i5"
Message-ID: <3626b4c0-319b-4944-b7ff-704ab146fd1e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781366227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kE0oeEtUJG66qm/U92HQCINAXsdcehQKkqnC/jbf8Tg=;
	b=giTr33i5UL68RXMestQ7k0qhojn0znSLAbcI8b+5lEkdTMM8PXWCVio9gTXmnSsGAopmdE
	3KSM2QJ/8YCaSCWBZp2QWvHnaQvkP+qRKy4IMBvnbu1diVDPfY+YegELUYINsQIv0TcDlU
	vpcZ2pHbm45TWe373RF9WFxBL3KmRAU=
Date: Sat, 13 Jun 2026 23:56:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v5 0/2] sysctl: add CTLTBL_ENTRY_XXX() macros for
 ctl_table initialization
To: Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1774463505.git.wen.yang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <cover.1774463505.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Kees, H jioel,

Gentle ping on this series. Please let me know if there are any
concerns or if further changes are needed.

The series is available at:
https://lore.kernel.org/all/x5stdwwsfp2h22zyexn5ycbxnkyc4ioxscninxsa6q7lf6djqr@jkuppwwqubkp/

Thanks for your time,
Wen


On 3/26/26 02:39, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> 
> Historically, changes to how struct ctl_table entries are initialized
> (e.g. removing the child field, const-qualifying ctl_table) required
> touching hundreds of files across all subsystems.  Such series require
> the attention of many maintainers, sometimes need to be pulled into
> mainline in a special way, and create lots of unnecessary churn.  With
> CTLTBL_ENTRY_XXX(), future structural changes to struct ctl_table need
> only update the macro definitions.
> 
> Conversion of existing call sites will proceed incrementally from
> kernel/sysctl.c outward, rather than as a treewide sweep.
> 
> This series:
>   1. Introduces the CTLTBL_ENTRY_XXX() macros in include/linux/sysctl.h,
>      using _Generic() for automatic proc_handler selection, auto
>      address-of, auto maxlen via sizeof(), and compile-time validation.
>      Supported types: int, unsigned int, long, unsigned long, bool, u8.
>   2. Converts kernel/sysctl-test.c as a demonstration, adding a
>      parameterized KUnit test covering all macro variants (V, VM, VMR,
>      VN, VNM, VNMH) across int, u8, bool, and char[] types.
> 
> Based on discussion and suggestions from:
> [1] https://sysctl-dev-rtd.readthedocs.io/en/latest/notes/ctltable_entry_macro.html
> [2] https://lore.kernel.org/all/psot4oeauxi3yyj2w4ajm3tfgtcsvao4rhv5sgd5s6ymmjgojk@p3vrj3qluban/
> 
> ---
> Changes in v5:
>    - Extend __CTL_AUTO_HANDLER to support bool and u8
>    - Replace individual test functions with a single parameterized KUnit
>      test (KUNIT_CASE_PARAM) covering all variants and types
>    - Use struct ctl_table as the expected-value container in the param
>      struct, eliminating custom expected_* fields
> 
> Changes in v4:
>    - Fix Wpointer-type-mismatch warnings detected by lkp:
>      https://lore.kernel.org/oe-kbuild-all/202603050724.SZxrEyyu-lkp@intel.com/
> 
> Changes in v3:
>    - Replace the unique macro with "capital letter approach"
>    - Reduce the name further
>    https://lore.kernel.org/all/rn4rsazh7kxf5byq65vw2phyqgzvwm3scczu3l5h2r4aqit2r6@znlpb24z2zuo/
> 
> Changes in v2:
>    - Add lvalue check, handler type check, etc.
>    https://lore.kernel.org/all/xptwb3uwbzposd4xf7khj52ifv4tchcjdgllhv7aabi6d7wgef@2msurl564v53/
> 
> 
> Wen Yang (2):
>    sysctl: introduce CTLTBL_ENTRY_XXX() helper macros
>    sysctl: convert kernel/sysctl-test.c to use CTLTBL_ENTRY_XXX()
> 
>   include/linux/sysctl.h | 307 +++++++++++++++++++++++++++++++++++++++++
>   kernel/sysctl-test.c   | 237 ++++++++++++++++++-------------
>   kernel/sysctl.c        |   2 +
>   3 files changed, 447 insertions(+), 99 deletions(-)
> 
