Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BA37AA8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852754; cv=none; b=r5JR8n8tXUeqbfk8gXvGf1F5mZjKWhCQFvEwJY6Uc4pJwuShZaXLZ0lGmu6kON6I1hvHAj950VweZbL959TbNmRfPdxfDUwSdKv5cyXscJq7Lo2Pdi1sAIxvkjBg6vrKgu2LgUGpycJR38Ed6uGwEuJlqPyPRolRFrtKd9UzJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852754; c=relaxed/simple;
	bh=JcClEwFZgAkKf6sTDheI6B6d6Sld8L6NsMZKHAiDr9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2DQ9NGr3aM1LJKMUPpFSGncXz1evcRqPm9vA1d2U3opr/0nDz0XjQ8eIlHCv+9RXVtC9aOQ2uw0iZTCVbJOoFm00fa3qdXsON3tPdxaEYls4XnUlDZByEC5v97m7gQ7QBDklzSXtYSqq8hwWO3D80/J9c8rLh8PRKwDl/qL4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5EAFE68C4E; Mon, 30 Mar 2026 08:39:10 +0200 (CEST)
Date: Mon, 30 Mar 2026 08:39:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com,
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com
Subject: Re: [PATCH 5/5] exfat: add support for SEEK_HOLE and SEEK_DATA in
 llseek
Message-ID: <20260330063910.GD5897@lst.de>
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-6-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326115045.9525-6-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	default:
> +		return generic_file_llseek_size(file, offset, whence,
> +						inode->i_sb->s_maxbytes,
> +						i_size_read(inode));

Just use generic_file_llseek directly here.

