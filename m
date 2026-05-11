Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3832B99F;
	Mon, 11 May 2026 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495513; cv=none; b=Du+lkdhqiAeA06zHXwPku8KaFH49PhJeCUQj5dtSLl7JI7BASieAajQ/RWGrenW4k9KH/6NRDfOBOmnYy+5DWBRGFI9J/hcn+H+cb1VKezkyNiYMfexnqOUtba8dkduiYsUficnQ7ANvSzJK8LZwhN6x4D3lYf2tQYZHeU7tT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495513; c=relaxed/simple;
	bh=OP50wyFZhpMhkf/zN95lmO+GELRvqsbsY8yKPNJN8aE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YQTm2cqOB54KKPdNJjg/tyMsYzZS7j5IxLnLHK1+jCFqiX2vAMtV5+zJs5SN8OFsUhKNUbrWY2cBU5zh+wOGKvRS0arMNBQHw/n2usq+Dza+UUOCtJ1xsZFB+C+q7MY5K+DnPVlS/Aj2xEfkY0alGvJFzTWzmRPTTcE0/VXg8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2pb0G8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2pb0G8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D284C2BCC9;
	Mon, 11 May 2026 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778495513;
	bh=OP50wyFZhpMhkf/zN95lmO+GELRvqsbsY8yKPNJN8aE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=L2pb0G8TuL5Nx9rb+XWYGlsb2dKNhCQUik9jPZMvRcMj51/VB4vUO7AJey0Rjiwxh
	 BlTN4uodUSZXMhcdxUNQoXHn+x9NkSQq09rv9U+KAyeJbxFoo6JyJAKwMsCU3lM8+Z
	 9mEkCoHh9hEXihZGluZjt+r8s4jgkLI/By+I5xpSuqBTFZ1kdSHVZY+dLHisFHCda3
	 fY3AL5uLSplLNOnrIDL7Ik0oXxM9B065go7ePWORkCupgrKknyo4kA4tqEXOAhoGSc
	 J/TC983ehb3O+Z/gRmqUgeUQzpRmCtTsN8uLeB2M+FbsR2xyu5lpms3mGSUcrgtmtS
	 6yxeuQuzGrKKg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/2] selftest: add tests for O_EMPTYPATH
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Shuah Khan <shuah@kernel.org>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aleksa Sarai <aleksa@amutable.com>, 
 Wei Yang <richard.weiyang@gmail.com>, 
 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org
In-Reply-To: <20260424114611.1678641-3-jkoolstra@xs4all.nl>
References: <20260424114611.1678641-1-jkoolstra@xs4all.nl>
 <20260424114611.1678641-3-jkoolstra@xs4all.nl>
Date: Mon, 11 May 2026 12:31:39 +0200
Message-Id: <177849549988.77176.8322524962780350320.b4-review@b4>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OP50wyFZhpMhkf/zN95lmO+GELRvqsbsY8yKPNJN8aE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxbhA6teapfu5y94ZtEV6+CzJUuPXZhSdWC1lVcR/ac
 0O4Ke97RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWujEyzJoefW7199tOU66Z
 2vg46v7/8qokOGRO36RMPvczWplMdgx/hd4vzFrBvDd4ambUt40KfyUPS4rpPRQqcVHu/V/0Piy
 UDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 24 Apr 2026 13:46:03 +0200, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> diff --git a/tools/testing/selftests/filesystems/openat2/emptypath_test.c b/tools/testing/selftests/filesystems/openat2/emptypath_test.c
> new file mode 100644
> index 000000000000..d75b5e998ff9
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/openat2/emptypath_test.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define __SANE_USERSPACE_TYPES__
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +
> +#include "kselftest.h"
> +
> +#ifndef O_EMPTYPATH
> +#define O_EMPTYPATH	(1 << 26)
> +#endif
> +
> +int main(void)
> +{

Aleksa migrated the openat2() selftests to use the TEST*() framework.
Please send a follow-up path that converts your new selftest to use
TEST() as well. I'll either fold it or leave it standalone. IOW, send it
as a diff on top of vfs-7.2.misc, please.

-- 
Christian Brauner <brauner@kernel.org>
