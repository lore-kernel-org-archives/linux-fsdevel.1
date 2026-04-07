Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21A33F394
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605207; cv=none; b=cVUypEv3aXS/RjIoOk4d84gFr9Ii68yBUJTcqbaThh7fDln5KY32sk1kFfmVjUJFjcwOIhTNqoO26PHEVTfeihcHYIcAm4T3z7/YdxtUul8lB6+Brbv5Kwxu7YqXtyP8UUnOlmRm4c5reF7FQ4rw/FHn/jwiO1Ok0zHT57emKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605207; c=relaxed/simple;
	bh=gryN8HjHCf3N6/+M7CYzfLjTLvvdd7Kg0z+H8ROCbog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icAoyzHaKrqRDSa62t9BnXCncxTRE9EHcGs7odFNGA/uzglUd2tLzQUJU8II83J08KR6ksHE6Jtq5vvl/DovCaClChhPd1ShyQkh+4yXC4nVsQ/86gXKWWZ1XILL285Ka1vC59Z0PMeD4k05n+w4u5K7lJY2nTA8x66R3EN9Xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8JaHqIT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8JaHqIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29372C116C6;
	Tue,  7 Apr 2026 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775605207;
	bh=gryN8HjHCf3N6/+M7CYzfLjTLvvdd7Kg0z+H8ROCbog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8JaHqITzaMurHwspzfhMgE+cuf5bdauF1Jxc7R0TwvTgQcIgwi0yYEzpJcQrAXPz
	 c+84hdwWiBCCTwiaqFJhupM8gExDPVvXEr+qsi0gwfgY18fvf8qM4WqVeDtwnJymbH
	 V0I15sOR7Z+pEvD7xhtRj83Ar0IejyaESn+atiMyURkFvhAXSmC7S6YOrTcvOGi6fN
	 Zv05ZKq8QrPzgfMXSN66ju0fVmImsD3td8L1QFpveu/1mZr8IoswouIQx+cRQMZI8i
	 eFIaChOH14vYjCZEoKFbvdJiynj3QtVSxy64fsfyAsMSYqZFnoKBU8DpvjLdcdQbKw
	 gNymErVg6FPNw==
Date: Tue, 7 Apr 2026 16:40:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
	neal@gompa.dev, joannelkoong@gmail.com
Subject: Re: [PATCH 06/17] util: hoist the fuse.conf parsing code
Message-ID: <20260407234006.GO6202@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463223.1008428.12285787116252115387.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177457463223.1008428.12285787116252115387.stgit@frogsfrogsfrogs>

On Thu, Mar 26, 2026 at 06:26:20PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Move all the code that parses fuse.conf into a separate file in util/ so
> that fuservicemount can read the same file.  We'll add the limit
> enforcement in separate patches.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

I combined the two patches that hoisted code to fuser_conf.c into a
single one, and then did the same for the checkpatch cleanups.

--D
