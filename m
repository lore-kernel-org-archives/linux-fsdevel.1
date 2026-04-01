Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590433EAF9;
	Wed,  1 Apr 2026 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071703; cv=none; b=YOktIfmTfJhWrsqAJK/L4DbuXYn1KvZYpol5ccn7CPU6aCd4MSvXfSsM8NfHtDw3kvpgnd+MzIDU14HIHu6ushO2AP2yiUL9gBdwvFl5QlpIZByp1AR8GgvBmtG/0jORM9x9kZ2mMek1+VaCMvwpdEEnu94QLoBEol7zXj4J5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071703; c=relaxed/simple;
	bh=fme8hyEq6LPmNJncesjibWSiJqsBbRwNp/PF6ClVQXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCSmWS58SwVRIDCwT9HzYpcGX+V7S8bFB/T1kKCV95qa3rJpKSCocnPxVJThMgmMgzhVF96wElj75zJ1wprCsH7NoDJHg7N6+XcyR8JAbRYd/e5wXD54T6SteZx40dLae+tgmkeh84YpRxBNRTDsAnBRI2dCKnz9CEPIlh8bxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNbFpRGJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNbFpRGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3D3C4CEF7;
	Wed,  1 Apr 2026 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775071702;
	bh=fme8hyEq6LPmNJncesjibWSiJqsBbRwNp/PF6ClVQXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNbFpRGJl4xmGCqsJNjNwi7sck8ydvYFdoECaM+MI8+60dcA/yHsKwt6QrZ37uHXq
	 Ihkwn6X/Emc+wPN7z05vDcXTgFd2l0gLBPetCJ4Nk4KYlrNi3LI5jmFjvXvYHUaxRG
	 Ys6VuPShFGK4/6DKUIQ4Eua4SCmW3Xlw++iaDEX+fot9zXt03E4H463WCyMkW/YjJR
	 g+p/W7Grymw6Dl7CrJqLy5eceN5Xq7VT+JhE8t4OhbI8+hjY5dBbrHdE5TCu2q1kM3
	 bck3YUxwwrPbPp5E5ipAPgqv2o3KpZRHi1WoKIaYoU2Amhfg4PINjIVQ2RMeN6Blm3
	 2rBxRXchglkcQ==
From: Kees Cook <kees@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: use strnlen() in __set_task_comm
Date: Wed,  1 Apr 2026 12:28:17 -0700
Message-Id: <177507169460.2890967.1588878662313985569.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152039.724811-3-thorsten.blum@linux.dev>
References: <20260401152039.724811-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 01 Apr 2026 17:20:40 +0200, Thorsten Blum wrote:
> Use strnlen() to limit source string scanning to 'TASK_COMM_LEN - 1'
> bytes.
> 
> 

Applied to for-next/execve, thanks!

[1/2] exec: use strnlen() in __set_task_comm
      https://git.kernel.org/kees/c/10cd6758e054
[2/2] sched: update task_struct->comm comment
      https://git.kernel.org/kees/c/9bf092c97b86

Take care,

-- 
Kees Cook

