Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09136C9D5;
	Wed, 12 Aug 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520774; cv=none; b=tCjw3BzL2eOI0mU2b3/5fMZHJ4eiDlu13wxwxtoN4eb/RrzwKSqig/SlLJw4wlmZcBl0MaKuhd6td4buP37VFESAcNgaLA2L2ZSiKlobOjGZhDP/+LRnEOaHPmJD3WbGfal+8jU9OBlgaBDxE0gAZX2w/TserF1r9Y+I+m9W3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520774; c=relaxed/simple;
	bh=7ABqeFnNFzWU4U21w6F1TtoY0jLu84sEOh3/4nhyGKM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OCFkKgBf0VrfeyGNOWXPL4uKusTJF+r29YAtyrfh80Aw0NNbD4zTXxQRa3cTC0IryQpL/v/2gXuVz+ZjaKG3XHzDA5ESLtonY8c9VYyRRZcXMDtTG38oiWkb6h7hXTsvUWIBfo7ZlodV2NOTE+QHyXshcovFJwY+Fa/YBytFR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJa/i+PT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJa/i+PT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D41F000E9;
	Wed, 12 Aug 2026 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520772;
	bh=jjF1aGPxcl4QD71un8cdAmPyq7dVfBKkKWfyRh1LcoM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=mJa/i+PTQrWiAy+7ZaXO8KmZafcBHB5k5wlVt+4KgOxgsBBOXtVb5Qa3AiIh77n0+
	 mjin/qYB73ATpRWl/OGB0wJTOrt+kBMU2KC+sWSa2t7AvNaY2+hd4Nu+NNEqwwjMd6
	 ET8Z6K7BrRylM8ffCFDbemXWOcgcmOLs7rJfgQmf04ioL9w4QxYv49fxy1NwCaHRyX
	 gb0LTU52fkZUS4pZq/+hVeyBJSVYMok0Wv99BuU42Kvy+LxmiWfl+CtR2fK7Z1l7sG
	 a8+24z3wBZFwyOEppwOLOckMsVAqk8ZW6Yvire5PnKmdedikI6Hu49a7iCpNdVnx/N
	 b/EoDk5I8Dxng==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] vfs: report truthful FIDEDUPERANGE progress safely
From: Christian Brauner <brauner@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ansgar_L=C3=B6=C3=9Fer?= <ansgar.loesser@kom.tu-darmstadt.de>, 
 "Darrick J . Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
 Amir Goldstein <amir73il@gmail.com>
In-Reply-To: <20260805071414.3414870-1-matthias.goergens@gmail.com>
References: <20260805071414.3414870-1-matthias.goergens@gmail.com>
Date: Wed, 12 Aug 2026 09:46:08 +0200
Message-Id: <20260812-gastgewerbe-dementieren-landzunge-db991673a96a@brauner>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7ABqeFnNFzWU4U21w6F1TtoY0jLu84sEOh3/4nhyGKM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVqByaF57iwnonsc/eeN1K9p6Y+D1lD5lP3/+fdUtW7
 Kf9eT32jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl4f2X4p2gq+oDZ5LvnbEGF
 W8fkm0smn2oI1r12/5hh0I41/1YqdTEyfMstXs3OF756pmx8wqR/McInm4JnrVs6/eCxLcrmc/X
 zmQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-08-05 15:14 +0800, Matthias Goergens wrote:
> FIDEDUPERANGE currently reports the requested length even when the
> filesystem shortens a destination range and deduplicates fewer bytes. A
> previous one-line correction was reverted after generic/517 exposed the old
> expectation and reviewers raised the risk that existing consumers could loop
> on a successful zero-progress result.
> 
> Patch 1 makes a non-zero request shortened to zero fail per destination with
> -EINVAL, while preserving explicit zero-length success. Patch 2 then reports
> the filesystem's actual positive progress. This ordering keeps every
> intermediate kernel safe for callers that advance by bytes_deduped.
> 
> The paired fstests update corrects generic/517 and adds raw ioctl coverage for
> zero-length and mixed multi-destination results. Both tests pass on Btrfs and
> XFS. Installed duperemove exits successfully on the measured corpus. Installed
> rmlint does not hang or silently over-report; it exits 1 after the final
> unaligned tail receives -EINVAL, which is recorded explicitly for review.
> 
> A current-source consumer audit supports that ABI choice: duperemove completes
> the request on a non-zero status; rmlint, bees and jdupes surface -EINVAL as
> failure without retrying; dduper and xfs_io stop but can still report command
> success. None retries, hangs or risks data corruption. Thus -EINVAL is the
> only truthful result that also avoids exposing successful zero progress to
> deployed duperemove binaries.
> 
> Matthias Goergens (2):
>   vfs: fail dedupe requests that cannot make progress
>   vfs: report the amount of bytes actually deduplicated

Needs input from Amir.

